import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _pushEnabled = true;
  bool _quizReminders = true;
  bool _lessonUpdates = false;
  bool _weeklyReport = true;
  bool _achievements = true;
  bool _emailNotifs = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF24304A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF24304A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _NotifSection(
            title: 'Push Notifications',
            items: [
              _NotifItem(
                icon: Icons.notifications_active_outlined,
                label: 'Enable Push Notifications',
                subtitle: 'Receive alerts on your device',
                value: _pushEnabled,
                onChanged: (v) => setState(() => _pushEnabled = v),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _NotifSection(
            title: 'Learning Alerts',
            items: [
              _NotifItem(
                icon: Icons.quiz_outlined,
                label: 'Quiz Reminders',
                subtitle: 'Get reminded before scheduled quizzes',
                value: _quizReminders,
                onChanged: (v) => setState(() => _quizReminders = v),
              ),
              _NotifItem(
                icon: Icons.auto_stories_outlined,
                label: 'New Lesson Updates',
                subtitle: 'When new lessons are available',
                value: _lessonUpdates,
                onChanged: (v) => setState(() => _lessonUpdates = v),
              ),
              _NotifItem(
                icon: Icons.emoji_events_outlined,
                label: 'Achievements',
                subtitle: 'When you earn badges or rewards',
                value: _achievements,
                onChanged: (v) => setState(() => _achievements = v),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _NotifSection(
            title: 'Reports',
            items: [
              _NotifItem(
                icon: Icons.bar_chart_outlined,
                label: 'Weekly Progress Report',
                subtitle: 'Summary of your weekly activity',
                value: _weeklyReport,
                onChanged: (v) => setState(() => _weeklyReport = v),
              ),
              _NotifItem(
                icon: Icons.mail_outline,
                label: 'Email Notifications',
                subtitle: 'Receive updates via email',
                value: _emailNotifs,
                onChanged: (v) => setState(() => _emailNotifs = v),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotifSection extends StatelessWidget {
  final String title;
  final List<_NotifItem> items;

  const _NotifSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5B6AF5),
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items.map((item) {
              final isLast = items.last == item;
              return Column(
                children: [
                  item,
                  if (!isLast) const Divider(height: 1, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _NotifItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotifItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon,
              color: value ? const Color(0xFF5B6AF5) : Colors.grey, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF5B6AF5),
          ),
        ],
      ),
    );
  }
}