import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  final bool showBackButton;
  const RewardsScreen({super.key, this.showBackButton = true});

  static const int _total = 124;
  static const int _next  = 200;

  static const List<Map<String, dynamic>> _badges = [
    {'emoji': '🌟', 'title': 'Super Starter',  'needed': 0,   'earned': true},
    {'emoji': '📚', 'title': 'Book Worm',       'needed': 0,   'earned': true},
    {'emoji': '🎨', 'title': 'Art Star',        'needed': 150, 'earned': false},
    {'emoji': '🧠', 'title': 'Brain Champ',     'needed': 200, 'earned': false},
    {'emoji': '🚀', 'title': 'Rocket Kid',      'needed': 300, 'earned': false},
    {'emoji': '👑', 'title': 'Study King',      'needed': 500, 'earned': false},
  ];

  static const List<Map<String, dynamic>> _history = [
    {'emoji': '✅', 'desc': 'Completed: Sing the color song',  'stars': 4,  'when': 'Today'},
    {'emoji': '✅', 'desc': 'Completed: Count 10 objects',     'stars': 5,  'when': 'Today'},
    {'emoji': '📖', 'desc': 'Finished Lesson: ABC Song',       'stars': 10, 'when': 'Yesterday'},
    {'emoji': '📝', 'desc': 'Submitted: Color the Shapes',     'stars': 10, 'when': 'Mon'},
    {'emoji': '📖', 'desc': 'Finished Lesson: Numbers 1–20',   'stars': 10, 'when': 'Mon'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: showBackButton
            ? GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.pink.shade200),
            ),
            child: Icon(Icons.arrow_back_ios_rounded,
                size: 16, color: Colors.pink.shade600),
          ),
        )
            : null,
        title: Row(children: [
          const Text('🏆', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Text(
            'Star Rewards',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.pink.shade700,
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Star hero card ────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade400, Colors.orange.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(children: [
              const Text('⭐', style: TextStyle(fontSize: 52)),
              const SizedBox(height: 6),
              const Text(
                '$_total',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Total Stars Earned',
                style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),
              // Progress to next badge
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Next badge at $_next ⭐',
                          style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text('$_total / $_next',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _total / _next,
                      minHeight: 10,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      color: Colors.white,
                    ),
                  ),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 24),

          // ── Badges ────────────────────────────────────────────────
          Row(children: [
            const Text('🏅', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            const Text(
              'My Badges',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
            ),
          ]),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.88,
            ),
            itemCount: _badges.length,
            itemBuilder: (_, i) => _BadgeTile(badge: _badges[i]),
          ),
          const SizedBox(height: 24),

          // ── Recent earnings ───────────────────────────────────────
          Row(children: [
            const Text('📋', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            const Text(
              'Recent Earnings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
            ),
          ]),
          const SizedBox(height: 14),
          ..._history.map((h) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(children: [
                Text(h['emoji'] as String, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(h['desc'] as String,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E))),
                    Text(h['when'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Text(
                    '+${h['stars']} ⭐',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.amber.shade700,
                    ),
                  ),
                ),
              ]),
            ),
          )),
        ]),
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final Map<String, dynamic> badge;
  const _BadgeTile({required this.badge});

  @override
  Widget build(BuildContext context) {
    final bool earned = badge['earned'] as bool;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: earned ? const Color(0xFFFFFBEB) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: earned ? const Color(0xFFFDE68A) : Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (earned ? Colors.amber : Colors.black).withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          badge['emoji'] as String,
          style: TextStyle(
            fontSize: 30,
            color: earned ? null : Colors.black.withOpacity(0.2),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          badge['title'] as String,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: earned ? const Color(0xFF1A1A2E) : Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          earned ? '🎉 Earned!' : '${badge['needed']}⭐',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: earned ? Colors.green.shade600 : Colors.grey.shade400,
          ),
        ),
      ]),
    );
  }
}