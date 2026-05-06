import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final bool showBackButton;
  const ProfileScreen({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: showBackButton
            ? GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: Icon(Icons.arrow_back_ios_rounded,
                size: 16, color: Colors.purple.shade600),
          ),
        )
            : null,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          const Text('👤', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            'My Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.purple.shade700,
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // ── Profile hero ──────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            color: Colors.white,
            child: Column(children: [
              // Avatar with glow
              Stack(children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade300, Colors.purple.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.4),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('😊', style: TextStyle(fontSize: 44)),
                  ),
                ),
                // Star badge
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade400,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: const Center(child: Text('⭐', style: TextStyle(fontSize: 12))),
                  ),
                ),
              ]),
              const SizedBox(height: 14),
              const Text(
                'Elne',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Text(
                  'Kindergarten · Class Bee 🐝',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.purple.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // Stats
              Row(children: [
                _StatBox(value: '124', label: 'Stars', emoji: '⭐', color: Colors.amber.shade600),
                _VDivider(),
                _StatBox(value: '7', label: 'Lessons', emoji: '📖', color: Colors.orange.shade500),
                _VDivider(),
                _StatBox(value: '2', label: 'Badges', emoji: '🏅', color: Colors.purple.shade500),
              ]),
            ]),
          ),

          const SizedBox(height: 12),

          // ── Streak banner ─────────────────────────────────────────
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade400, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(children: [
              const Text('🔥', style: TextStyle(fontSize: 32)),
              const SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text(
                  '3-Day Streak! Keep it up!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Learn every day to grow your streak 🌱',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ]),
            ]),
          ),

          const SizedBox(height: 20),

          // ── Menu sections ─────────────────────────────────────────
          _MenuSection(title: '👤  Account', color: Colors.purple, items: [
            _MenuRow(icon: Icons.person_outline_rounded,      label: 'My Profile',       iconColor: Colors.purple),
            _MenuRow(icon: Icons.notifications_outlined,       label: 'Notifications',    iconColor: Colors.orange),
            _MenuRow(icon: Icons.lock_outline_rounded,         label: 'Privacy & Safety', iconColor: Colors.teal),
            _MenuRow(icon: Icons.palette_outlined,             label: 'Appearance',       iconColor: Colors.pink),
          ]),
          const SizedBox(height: 12),

          _MenuSection(title: '📚  Learning', color: Colors.orange, items: [
            _MenuRow(icon: Icons.bar_chart_rounded,            label: 'My Progress',      iconColor: Colors.green),
            _MenuRow(icon: Icons.emoji_events_outlined,        label: 'Achievements',     iconColor: Colors.amber),
            _MenuRow(icon: Icons.history_rounded,              label: 'Activity History', iconColor: Colors.blue),
          ]),
          const SizedBox(height: 12),

          _MenuSection(title: '💬  Support', color: Colors.teal, items: [
            _MenuRow(icon: Icons.help_outline_rounded,         label: 'Help Center',      iconColor: Colors.grey),
            _MenuRow(icon: Icons.info_outline_rounded,         label: 'About StudyNest',  iconColor: Colors.grey),
          ]),

          const SizedBox(height: 16),

          // ── Sign out ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red.shade200, width: 1.5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {},
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.logout_rounded, color: Colors.red.shade400, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────
class _StatBox extends StatelessWidget {
  final String value, label, emoji;
  final Color color;
  const _StatBox({required this.value, required this.label, required this.emoji, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 4),
      Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color)),
      Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ]),
  );
}

class _VDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(height: 40, width: 1, color: Colors.grey.shade200);
}

class _MenuSection extends StatelessWidget {
  final String title;
  final Color color;
  final List<_MenuRow> items;
  const _MenuSection({required this.title, required this.color, required this.items});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(
          title,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: List.generate(items.length, (i) => Column(children: [
            items[i],
            if (i < items.length - 1)
              Divider(height: 1, indent: 58, color: Colors.grey.shade100),
          ])),
        ),
      ),
    ]),
  );
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  const _MenuRow({required this.icon, required this.label, required this.iconColor});

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E))),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade400),
        ]),
      ),
    ),
  );
}