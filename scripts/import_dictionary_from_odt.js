#!/usr/bin/env node

const fs = require('node:fs');
const path = require('node:path');
const { execFileSync } = require('node:child_process');
const admin = require('firebase-admin');

const ALLOWED_CATEGORIES = new Set([
  'jerga_gamer',
  'mecánicas_juego',
  'plataformas',
]);

function parseArgs(argv) {
  const args = {};

  for (let i = 0; i < argv.length; i += 1) {
    const token = argv[i];
    if (!token.startsWith('--')) continue;

    const key = token.slice(2);
    const next = argv[i + 1];

    if (!next || next.startsWith('--')) {
      args[key] = true;
      continue;
    }

    args[key] = next;
    i += 1;
  }

  return args;
}

function decodeXmlEntities(text) {
  return text
    .replaceAll(/&#x([0-9a-fA-F]+);/g, (_, hex) =>
      String.fromCodePoint(Number.parseInt(hex, 16))
    )
    .replaceAll(/&#(\d+);/g, (_, dec) =>
      String.fromCodePoint(Number.parseInt(dec, 10))
    )
    .replaceAll('&amp;', '&')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&apos;', "'");
}

function xmlToPlain(xmlChunk) {
  const withSpacing = xmlChunk
    .replaceAll(/<text:s(?:\s+text:c="(\d+)")?\s*\/>/g, (_, count) =>
      ' '.repeat(count ? Number(count) : 1)
    )
    .replaceAll(/<text:tab\s*\/>/g, '\t')
    .replaceAll(/<text:line-break\s*\/>/g, '\n');

  const noTags = withSpacing.replaceAll(/<[^>]+>/g, '');
  const decoded = decodeXmlEntities(noTags);

  return decoded
    .split('\n')
    .map((line) => line.trim())
    .join('\n')
    .trim();
}

function normalizeTerm(value) {
  return value
    .normalize('NFD')
    .replaceAll(/[\u0300-\u036f]/g, '')
    .replaceAll(/\s+/g, ' ')
    .trim()
    .toLowerCase();
}

function normalizeCategory(rawCategory, fallbackCategory) {
  if (!rawCategory) return fallbackCategory;

  const category = rawCategory.trim().toLowerCase();

  if (ALLOWED_CATEGORIES.has(category)) {
    return category;
  }

  if (category.includes('mecan')) {
    return 'mecánicas_juego';
  }

  if (category.includes('plataform')) {
    return 'plataformas';
  }

  if (category.includes('jerga') || category.includes('gamer')) {
    return 'jerga_gamer';
  }

  return fallbackCategory;
}

function parseFromTableRows(contentXml, defaultCategory) {
  const rowRegex = /<table:table-row\b[\s\S]*?<\/table:table-row>/g;
  const rows = contentXml.match(rowRegex) || [];
  const parsed = [];

  for (const row of rows) {
    const cellRegex = /<table:table-cell\b[\s\S]*?<\/table:table-cell>/g;
    const cells = row.match(cellRegex) || [];
    if (cells.length < 2) continue;

    const values = cells.map((cell) => {
      const paragraphs = cell.match(/<text:p\b[^>]*>[\s\S]*?<\/text:p>/g) || [];
      if (!paragraphs.length) return '';
      return paragraphs.map((p) => xmlToPlain(p)).filter(Boolean).join('\n').trim();
    });

    const [term, definition, example, category] = values;
    if (!term || !definition) continue;

    parsed.push({
      term: term.trim(),
      definition: definition.trim(),
      example: (example || '').trim(),
      category: normalizeCategory(category, defaultCategory),
    });
  }

  if (!parsed.length) {
    return parsed;
  }

  const first = parsed[0];
  const headerLike =
    /term|t[eé]rmino/i.test(first.term) && /defin/i.test(first.definition);

  return headerLike ? parsed.slice(1) : parsed;
}

function parseFromParagraphs(contentXml, defaultCategory) {
  const paragraphRegex = /<text:p\b[^>]*>[\s\S]*?<\/text:p>/g;
  const paragraphs = (contentXml.match(paragraphRegex) || [])
    .map((p) => xmlToPlain(p))
    .map((line) => line.trim())
    .filter(Boolean);

  const parsed = [];

  for (const line of paragraphs) {
    const match = line.match(/^([^:–-]{2,80})\s*[:–-]\s*(.{8,})$/);
    if (!match) continue;

    const term = match[1].trim();
    const definition = match[2].trim();

    if (!term || !definition) continue;

    parsed.push({
      term,
      definition,
      example: '',
      category: defaultCategory,
    });
  }

  return parsed;
}

function parseOdtDictionary(odtPath, defaultCategory) {
  const contentXml = execFileSync('unzip', ['-p', odtPath, 'content.xml'], {
    encoding: 'utf8',
  });

  const fromTable = parseFromTableRows(contentXml, defaultCategory);
  if (fromTable.length > 0) {
    return fromTable;
  }

  return parseFromParagraphs(contentXml, defaultCategory);
}

function deduplicateEntries(entries) {
  const map = new Map();

  for (const entry of entries) {
    const key = normalizeTerm(entry.term);
    if (!key) continue;
    if (!map.has(key)) {
      map.set(key, entry);
    }
  }

  return Array.from(map.values());
}

function printUsage() {
  console.log('Uso:');
  console.log(
    '  node scripts/import_dictionary_from_odt.js --file <ruta.odt> --admin-uid <uid> [opciones]'
  );
  console.log('');
  console.log('Opciones:');
  console.log('  --service-account <ruta.json>   Credenciales de service account');
  console.log('  --collection <nombre>           Colección destino (default: dictionary_terms)');
  console.log('  --default-category <valor>      Categoría por defecto (default: jerga_gamer)');
  console.log('  --dry-run                       Solo valida y muestra resumen sin escribir');
}

function initFirebase(serviceAccountPath) {
  if (admin.apps.length > 0) return;

  if (serviceAccountPath) {
    const absolutePath = path.resolve(serviceAccountPath);
    const credentials = JSON.parse(fs.readFileSync(absolutePath, 'utf8'));

    if (!credentials.private_key || !credentials.client_email) {
      throw new Error(
        'El archivo indicado no es un service account válido. google-services.json no sirve para firebase-admin; necesitas un JSON de service account con private_key y client_email.'
      );
    }

    admin.initializeApp({
      credential: admin.credential.cert(credentials),
    });
    return;
  }

  admin.initializeApp({
    credential: admin.credential.applicationDefault(),
  });
}

async function main() {
  try {
    const args = parseArgs(process.argv.slice(2));
    const odtPath = args.file;
    const adminUid = args['admin-uid'];
    const serviceAccountPath = args['service-account'];
    const collectionName = args.collection || 'dictionary_terms';
    const defaultCategory = normalizeCategory(
      args['default-category'] || 'jerga_gamer',
      'jerga_gamer'
    );
    const dryRun = Boolean(args['dry-run']);

    if (!odtPath || !adminUid) {
      printUsage();
      process.exitCode = 1;
      return;
    }

    const absoluteOdtPath = path.resolve(odtPath);

    if (!fs.existsSync(absoluteOdtPath)) {
      throw new Error(`No existe el archivo ODT: ${absoluteOdtPath}`);
    }

    initFirebase(serviceAccountPath);

    const parsedEntries = parseOdtDictionary(absoluteOdtPath, defaultCategory);
    const uniqueEntries = deduplicateEntries(parsedEntries);

    if (!uniqueEntries.length) {
      throw new Error('No se encontraron términos válidos en el archivo ODT.');
    }

    const db = admin.firestore();

    const existingSnapshot = await db.collection(collectionName).select('term').get();
    const existingTerms = new Set(
      existingSnapshot.docs
        .map((doc) => doc.get('term'))
        .filter((value) => typeof value === 'string')
        .map((value) => normalizeTerm(value))
    );

    const toInsert = uniqueEntries.filter(
      (entry) => !existingTerms.has(normalizeTerm(entry.term))
    );

    console.log(`Términos leídos: ${parsedEntries.length}`);
    console.log(`Términos únicos en fichero: ${uniqueEntries.length}`);
    console.log(`Ya existentes en Firestore: ${uniqueEntries.length - toInsert.length}`);
    console.log(`Nuevos a insertar: ${toInsert.length}`);

    if (dryRun || toInsert.length === 0) {
      console.log(dryRun ? 'Dry-run completado. No se realizaron escrituras.' : 'No hay cambios que aplicar.');
      return;
    }

    let batch = db.batch();
    let operations = 0;
    let inserted = 0;

    for (const entry of toInsert) {
      const docRef = db.collection(collectionName).doc();
      batch.set(docRef, {
        term: entry.term,
        definition: entry.definition,
        example: entry.example,
        category: entry.category,
        status: 'approved',
        proposedBy: adminUid,
        approvedBy: adminUid,
        votes: 0,
        viewCount: 0,
        rejectionReason: null,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      operations += 1;
      inserted += 1;

      if (operations === 450) {
        await batch.commit();
        batch = db.batch();
        operations = 0;
      }
    }

    if (operations > 0) {
      await batch.commit();
    }

    await db.collection('users').doc(adminUid).set(
      {
        termsProposed: admin.firestore.FieldValue.increment(inserted),
        termsApproved: admin.firestore.FieldValue.increment(inserted),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true }
    );

    console.log(`Importación completada. Insertados: ${inserted}`);
  } catch (error) {
    console.error('Error durante la importación:', error.message);
    process.exitCode = 1;
  }
}

main();
