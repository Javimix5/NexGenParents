import 'package:flutter/material.dart';

class ForumSidebar extends StatelessWidget {
  final bool isDark;

  const ForumSidebar({
    super.key,
    required this.isDark,
  });

  String _t(BuildContext context, {required String es, required String gl, required String en}) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'gl': return gl;
      case 'en': return en;
      default: return es;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      _t(context, es: 'Temas Seguidos', gl: 'Temas Seguidos', en: 'Followed Topics'),
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarTopicItem(title: _t(context, es: '¿Límites de tiempo para niños de 10 años?', gl: 'Límites de tempo para nenos de 10 anos?', en: 'Screen time limits for 10 year olds?'), subtitle: _t(context, es: '24 respuestas nuevas hoy', gl: '24 respostas novas hoxe', en: '24 new replies today'), isDark: isDark),
              _SidebarTopicItem(title: _t(context, es: 'Los mejores juegos educativos en Switch', gl: 'Os mellores xogos educativos en Switch', en: 'Best educational games on Switch'), subtitle: _t(context, es: '15 respuestas nuevas hoy', gl: '15 respostas novas hoxe', en: '15 new replies today'), isDark: isDark),
              _SidebarTopicItem(title: _t(context, es: 'Cómo gestionar la seguridad en chats online', gl: 'Como xestionar a seguridade en chats online', en: 'Dealing with online chat safety'), subtitle: _t(context, es: '8 respuestas nuevas hoy', gl: '8 respostas novas hoxe', en: '8 new replies today'), isDark: isDark, showDivider: false),
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
                      _t(context, es: 'Respuestas para ti', gl: 'Respostas para ti', en: 'Replies to you'),
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarReplyItem(avatar: 'S', name: 'Sarah M.', link: _t(context, es: 'Seguridad en Fortnite', gl: 'Seguridade en Fortnite', en: 'Fortnite Safety'), action: _t(context, es: 'respondió a tu co...', gl: 'respondeu ao teu co...', en: 'replied to your co...'), time: _t(context, es: 'hace 2 minutos', gl: 'hai 2 minutos', en: '2 minutes ago'), isDark: isDark, avatarColor: const Color(0xFFEC4899)),
              _SidebarReplyItem(avatar: 'D', name: 'David K.', link: _t(context, es: 'Comparativa de consolas', gl: 'Comparativa de consolas', en: 'Console Comparison'), action: _t(context, es: 'te etiquetó en...', gl: 'etiquetoute en...', en: 'tagged you in...'), time: _t(context, es: 'hace 1 hora', gl: 'hai 1 hora', en: '1 hour ago'), isDark: isDark, avatarColor: const Color(0xFF3B82F6)),
              _SidebarReplyItem(avatar: 'E', name: 'Emily R.', link: _t(context, es: 'Hilo de Bienvenida', gl: 'Fío de Benvida', en: 'Welcome Thread'), action: _t(context, es: 'le gustó tu respue...', gl: 'gustoulle a túa respo...', en: 'liked your reply i...'), time: _t(context, es: 'hace 3 horas', gl: 'hai 3 horas', en: '3 hours ago'), isDark: isDark, avatarColor: const Color(0xFF10B981), showDivider: false),
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
                      _t(context, es: 'Noticias Globales del Foro', gl: 'Novas Globais do Foro', en: 'Global Forum News'),
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarNewsItem(tag: _t(context, es: 'Actualización', gl: 'Actualización', en: 'Update'), tagColor: const Color(0xFF8B5CF6), text: _t(context, es: 'Nuevas guías de control parental añadidas al Diccionario.', gl: 'Novas guías de control parental engadidas ao Dicionario.', en: 'New parental control guides added to the Dictionary.'), isDark: isDark),
              const SizedBox(height: 8),
              _SidebarNewsItem(tag: _t(context, es: 'Evento', gl: 'Evento', en: 'Event'), tagColor: const Color(0xFF3B82F6), text: _t(context, es: 'Q&A en vivo con psicólogo infantil este jueves a las 18:00.', gl: 'Q&A en directo con psicólogo infantil este xoves ás 18:00.', en: 'Live Q&A with child psychologist this Thursday at 6PM.'), isDark: isDark),
              const SizedBox(height: 8),
              _SidebarNewsItem(tag: _t(context, es: 'Novedad', gl: 'Novidade', en: 'Feature'), tagColor: const Color(0xFF10B981), text: _t(context, es: '¡El modo oscuro ya está disponible en los ajustes de usuario!', gl: 'O modo escuro xa está dispoñible nos axustes de usuario!', en: 'Dark mode is now available in user settings!'), isDark: isDark, showDivider: false),
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