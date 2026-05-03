import 'dart:convert';
import 'dart:io';

void main() async {
  // Rutas de las carpetas de origen y destino
  final srcDir = Directory('lib/l10n/src');
  final outDir = Directory('lib/l10n');

  if (!await srcDir.exists()) {
    print('❌ Error: El directorio de origen no existe (${srcDir.path}).');
    print('Asegúrate de crear tus traducciones en carpetas como lib/l10n/src/es/');
    return;
  }

  // Asegurarnos de que el directorio de salida existe
  if (!await outDir.exists()) {
    await outDir.create(recursive: true);
  }

  // Leer subcarpetas dentro de lib/l10n/src (ej: es, en, gl)
  final languageDirs = srcDir.listSync().whereType<Directory>();

  for (final langDir in languageDirs) {
    // Extraer el código del idioma del nombre de la carpeta (ej: "es")
    final langCode = langDir.uri.pathSegments[langDir.uri.pathSegments.length - 2];
    final mergedJson = <String, dynamic>{};

    // 1. Añadir el locale de forma automática
    mergedJson['@@locale'] = langCode;

    // 2. Buscar todos los archivos .json o .arb en esta carpeta
    final files = langDir.listSync().whereType<File>().where(
          (f) => f.path.endsWith('.json') || f.path.endsWith('.arb'),
        );

    for (final file in files) {
      final content = await file.readAsString();
      if (content.trim().isEmpty) continue;

      try {
        final Map<String, dynamic> parsed = jsonDecode(content);
        
        // 3. Fusionar las llaves
        for (final key in parsed.keys) {
          if (key == '@@locale') continue; // Omitir si el archivo ya lo tenía
          
          if (mergedJson.containsKey(key)) {
            print('⚠️ ADVERTENCIA: Clave duplicada "$key" encontrada en ${file.path}. Se sobrescribirá el valor anterior.');
          }
          mergedJson[key] = parsed[key];
        }
      } catch (e) {
        print('❌ Error al analizar el JSON en ${file.path}: $e');
        print('Asegúrate de que el formato JSON sea correcto.');
      }
    }

    // 4. Guardar el archivo combinado (ej: lib/l10n/app_es.arb)
    final outFile = File('${outDir.path}/app_$langCode.arb');
    // Usamos JsonEncoder con indentación para que el archivo sea legible
    final encoder = const JsonEncoder.withIndent('    ');
    await outFile.writeAsString(encoder.convert(mergedJson));
    
    print('✅ Generado ${outFile.path} a partir de ${files.length} archivos.');
  }
}