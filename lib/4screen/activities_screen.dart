import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  final bool showBackButton;
  const ActivitiesScreen({super.key, this.showBackButton = true});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'emoji': '🔢',
      'title': 'Count 10 objects around you',
      'category': 'Math',
      'stars': 5,
      'done': true,
      'color': Color(0xFF16A34A),
      'bg': Color(0xFFDCFCE7),
    },
    {
      'emoji': '🎨',
      'title': 'Draw your favorite animal',
      'category': 'Art',
      'stars': 8,
      'done': false,
      'color': Color(0xFFD97706),
      'bg': Color(0xFFFFF3E0),
    },
    {
      'emoji': '🔤',
      'title': 'Trace the letters A B C',
      'category': 'Reading',
      'stars': 6,
      'done': false,
      'color': Color(0xFF7C3AED),
      'bg': Color(0xFFEDE9FE),
    },
    {
      'emoji': '🎵',
      'title': 'Sing the color song',
      'category': 'Music',
      'stars': 4,
      'done': true,
      'color': Color(0xFFDB2777),
      'bg': Color(0xFFFCE7F3),
    },
    {
      'emoji': '🔷',
      'title': 'Match the shapes worksheet',
      'category': 'Math',
      'stars': 10,
      'done': false,
      'color': Color(0xFF0284C7),
      'bg': Color(0xFFDFEFF7),
    },
    {
      'emoji': '📖',
      'title': 'Read 1 page of your storybook',
      'category': 'Reading',
      'stars': 7,
      'done': false,
      'color': Color(0xFFEA580C),
      'bg': Color(0xFFFFF3E0),
    },
  ];

  int get _doneCount => _tasks.where((t) => t['done'] == true).length;
  int get _totalStars =>
      _tasks.where((t) => t['done'] == true).fold(0, (s, t) => s + (t['stars'] as int));

  void _toggle(int i) => setState(() => _tasks[i]['done'] = !(_tasks[i]['done'] as bool));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.showBackButton
            ? GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Icon(Icons.arrow_back_ios_rounded,
                size: 16, color: Colors.red.shade600),
          ),
        )
            : null,
        title: Row(
          children: [
            const Text('✅', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.red.shade600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(children: [
          // ── Stats row ────────────────────────────────────────────
          Row(children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(children: [
                  Text(
                    '$_doneCount/${_tasks.length}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.red.shade500,
                    ),
                  ),
                  const Text('Done', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(children: [
                  Text(
                    '⭐ $_totalStars',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.amber.shade600,
                    ),
                  ),
                  const Text('Stars Earned', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
              ),
            ),
          ]),
          const SizedBox(height: 14),

          // ── Progress bar ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Progress",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1A1A2E)),
                  ),
                  Text(
                    '${(_doneCount / _tasks.length * 100).round()}%',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.red.shade500),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _doneCount / _tasks.length,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.red.shade400,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, top: 8, bottom: 4),
              child: Text(
                '👆 Tap a task to mark it done!',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final t = _tasks[i];
                final bool done = t['done'] as bool;
                final Color accent = t['color'] as Color;
                final Color bg = t['bg'] as Color;

                return GestureDetector(
                  onTap: () => _toggle(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: done ? bg : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: done ? accent.withOpacity(0.4) : Colors.grey.shade100,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: done ? accent.withOpacity(0.15) : Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(children: [
                      // Animated checkbox
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: done ? accent : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: done ? accent : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: done
                            ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 12),

                      // Emoji
                      Text(t['emoji'] as String, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 10),

                      // Text
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            t['title'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: done ? Colors.grey.shade500 : const Color(0xFF1A1A2E),
                              decoration: done ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              t['category'] as String,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: accent),
                            ),
                          ),
                        ]),
                      ),

                      // Stars badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber.shade200),
                        ),
                        child: Text(
                          '+${t['stars']} ⭐',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.amber.shade700,
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}