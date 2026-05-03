import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ForumSidebar extends StatelessWidget {
  final bool isDark;

  const ForumSidebar({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cardColor = isDark ? const Color(0xFF1A1A2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : Colors.black.withOpacity(0.08);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black54;

    return Column(
      children: [
        // ── Followed Topics ──
        _SidebarCard(
          isDark: isDark,
          cardColor: cardColor,
          borderColor: borderColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 4, height: 18, decoration: BoxDecoration(color: const Color(0xFF8B5CF6), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n?.forumSidebarFollowedTopics ?? 'Temas Seguidos',
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarTopicItem(
                  title: l10n?.forumSidebarTopic1Title ?? '¿Límites de tiempo para niños de 10 años?',
                  subtitle: l10n?.forumSidebarTopic1Subtitle ?? '24 respuestas nuevas hoy',
                  isDark: isDark),
              _SidebarTopicItem(
                  title: l10n?.forumSidebarTopic2Title ?? 'Los mejores juegos educativos en Switch',
                  subtitle: l10n?.forumSidebarTopic2Subtitle ?? '15 respuestas nuevas hoy',
                  isDark: isDark),
              _SidebarTopicItem(
                  title: l10n?.forumSidebarTopic3Title ?? 'Cómo gestionar la seguridad en chats online',
                  subtitle: l10n?.forumSidebarTopic3Subtitle ?? '8 respuestas nuevas hoy',
                  isDark: isDark,
                  showDivider: false),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Replies to you ──
        _SidebarCard(
          isDark: isDark,
          cardColor: cardColor,
          borderColor: borderColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 4, height: 18, decoration: BoxDecoration(color: const Color(0xFF8B5CF6), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n?.forumSidebarRepliesToYou ?? 'Respuestas para ti',
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarReplyItem(
                  avatar: 'S',
                  name: 'Sarah M.',
                  link: l10n?.forumSidebarReply1Link ?? 'Seguridad en Fortnite',
                  action: l10n?.forumSidebarReply1Action ?? 'respondió a tu co...',
                  time: l10n?.forumSidebarReply1Time ?? 'hace 2 minutos',
                  isDark: isDark,
                  avatarColor: const Color(0xFFEC4899)),
              _SidebarReplyItem(
                  avatar: 'D',
                  name: 'David K.',
                  link: l10n?.forumSidebarReply2Link ?? 'Comparativa de consolas',
                  action: l10n?.forumSidebarReply2Action ?? 'te etiquetó en...',
                  time: l10n?.forumSidebarReply2Time ?? 'hace 1 hora',
                  isDark: isDark,
                  avatarColor: const Color(0xFF3B82F6)),
              _SidebarReplyItem(
                  avatar: 'E',
                  name: 'Emily R.',
                  link: l10n?.forumSidebarReply3Link ?? 'Hilo de Bienvenida',
                  action: l10n?.forumSidebarReply3Action ?? 'le gustó tu respue...',
                  time: l10n?.forumSidebarReply3Time ?? 'hace 3 horas',
                  isDark: isDark,
                  avatarColor: const Color(0xFF10B981),
                  showDivider: false),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Global Forum News ──
        _SidebarCard(
          isDark: isDark,
          cardColor: cardColor,
          borderColor: borderColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.campaign_outlined, color: subColor, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l10n?.forumSidebarGlobalNews ?? 'Noticias Globales del Foro',
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarNewsItem(
                  tag: l10n?.forumSidebarNews1Tag ?? 'Actualización',
                  tagColor: const Color(0xFF8B5CF6),
                  text: l10n?.forumSidebarNews1Text ?? 'Nuevas guías de control parental añadidas al Diccionario.',
                  isDark: isDark),
              const SizedBox(height: 8),
              _SidebarNewsItem(
                  tag: l10n?.forumSidebarNews2Tag ?? 'Evento',
                  tagColor: const Color(0xFF3B82F6),
                  text: l10n?.forumSidebarNews2Text ?? 'Q&A en vivo con psicólogo infantil este jueves a las 18:00.',
                  isDark: isDark),
              const SizedBox(height: 8),
              _SidebarNewsItem(
                  tag: l10n?.forumSidebarNews3Tag ?? 'Novedad',
                  tagColor: const Color(0xFF10B981),
                  text: l10n?.forumSidebarNews3Text ?? '¡El modo oscuro ya está disponible en los ajustes de usuario!',
                  isDark: isDark,
                  showDivider: false),
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarCard extends StatelessWidget {
  final bool isDark;
  final Color cardColor;
  final Color borderColor;
  final Widget child;

  const _SidebarCard({required this.isDark, required this.cardColor, required this.borderColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: child,
    );
  }
}

class _SidebarTopicItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDark;
  final bool showDivider;

  const _SidebarTopicItem({required this.title, required this.subtitle, required this.isDark, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87)),
        const SizedBox(height: 2),
        Text(subtitle, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : Colors.black38)),
        if (showDivider) ...[
          const SizedBox(height: 8),
          Divider(color: isDark ? Colors.white10 : Colors.black12, height: 1),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _SidebarReplyItem extends StatelessWidget {
  final String avatar;
  final String name;
  final String link;
  final String action;
  final String time;
  final bool isDark;
  final Color avatarColor;
  final bool showDivider;

  const _SidebarReplyItem({required this.avatar, required this.name, required this.link, required this.action, required this.time, required this.isDark, required this.avatarColor, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 14, backgroundColor: avatarColor, child: Text(avatar, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(children: [TextSpan(text: name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)), TextSpan(text: link, style: const TextStyle(fontSize: 11, color: Color(0xFF8B5CF6))), TextSpan(text: ' $action', style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black54))])),
                  const SizedBox(height: 2),
                  Text(time, style: TextStyle(fontSize: 10, color: isDark ? Colors.white30 : Colors.black38)),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[const SizedBox(height: 8), Divider(color: isDark ? Colors.white10 : Colors.black12, height: 1), const SizedBox(height: 8)] else const SizedBox(height: 4),
      ],
    );
  }
}

class _SidebarNewsItem extends StatelessWidget {
  final String tag;
  final Color tagColor;
  final String text;
  final bool isDark;
  final bool showDivider;

  const _SidebarNewsItem({required this.tag, required this.tagColor, required this.text, required this.isDark, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: tagColor.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(tag, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: tagColor))), const SizedBox(height: 4), Text(text, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)), if (showDivider) ...[const SizedBox(height: 8), Divider(color: isDark ? Colors.white10 : Colors.black12, height: 1)]]);
  }
}