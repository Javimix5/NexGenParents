import 'package:flutter/material.dart';

class ForumSidebar extends StatelessWidget {
  final bool isDark;

  const ForumSidebar({
    super.key,
    required this.isDark,
  });

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
                  Text('Followed Topics', style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarTopicItem(title: 'Screen time limits for 10 year olds?', subtitle: '24 new replies today', isDark: isDark),
              _SidebarTopicItem(title: 'Best educational games on Switch', subtitle: '15 new replies today', isDark: isDark),
              _SidebarTopicItem(title: 'Dealing with online chat safety', subtitle: '8 new replies today', isDark: isDark, showDivider: false),
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
                  Text('Replies to you', style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarReplyItem(avatar: 'S', name: 'Sarah M.', link: 'Fortnite Safety', action: 'replied to your co...', time: '2 minutes ago', isDark: isDark, avatarColor: const Color(0xFFEC4899)),
              _SidebarReplyItem(avatar: 'D', name: 'David K.', link: 'Console Comparison', action: 'tagged you in...', time: '1 hour ago', isDark: isDark, avatarColor: const Color(0xFF3B82F6)),
              _SidebarReplyItem(avatar: 'E', name: 'Emily R.', link: 'Welcome Thread', action: 'liked your reply i...', time: '3 hours ago', isDark: isDark, avatarColor: const Color(0xFF10B981), showDivider: false),
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
                  Text('Global Forum News', style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              _SidebarNewsItem(tag: 'Update', tagColor: const Color(0xFF8B5CF6), text: 'New parental control guides added to the Dictionary.', isDark: isDark),
              const SizedBox(height: 8),
              _SidebarNewsItem(tag: 'Event', tagColor: const Color(0xFF3B82F6), text: 'Live Q&A with child psychologist this Thursday at 6PM.', isDark: isDark),
              const SizedBox(height: 8),
              _SidebarNewsItem(tag: 'Feature', tagColor: const Color(0xFF10B981), text: 'Dark mode is now available in user settings!', isDark: isDark, showDivider: false),
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