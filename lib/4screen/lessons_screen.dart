import 'package:flutter/material.dart';
import 'package:mystudynestflutter/4screen/lesson_detail_screen.dart';

class LessonsScreen extends StatelessWidget {
  final bool showBackButton;
  const LessonsScreen({super.key, this.showBackButton = true});

  static const List<Map<String, dynamic>> lessons = [
    {
      'emoji': '🔢',
      'title': 'Numbers 1–20',
      'subject': 'Math',
      'duration': '5 min',
      'lessonNo': 1,
      'done': true,
      'bg': Color(0xFFFFF9C4),
      'accent': Color(0xFFF9A825),
      'desc': 'Count and recognize numbers from 1 to 20 with Nesty!',
    },
    {
      'emoji': '🔤',
      'title': 'ABC Song',
      'subject': 'Reading',
      'duration': '4 min',
      'lessonNo': 2,
      'done': true,
      'bg': Color(0xFFEDE9FE),
      'accent': Color(0xFF7C3AED),
      'desc': 'Sing along and learn all 26 letters of the alphabet!',
    },
    {
      'emoji': '🌈',
      'title': 'Colors & Shapes',
      'subject': 'Art',
      'duration': '6 min',
      'lessonNo': 3,
      'done': false,
      'bg': Color(0xFFDCFCE7),
      'accent': Color(0xFF16A34A),
      'desc': 'Discover rainbow colors and fun shapes all around us!',
    },
    {
      'emoji': '🐾',
      'title': 'Animals Around Us',
      'subject': 'Science',
      'duration': '7 min',
      'lessonNo': 4,
      'done': false,
      'bg': Color(0xFFFFE4E6),
      'accent': Color(0xFFE11D48),
      'desc': 'Meet animals and learn where they live and what they eat!',
    },
    {
      'emoji': '🌤️',
      'title': 'Weather & Seasons',
      'subject': 'Science',
      'duration': '5 min',
      'lessonNo': 5,
      'done': false,
      'bg': Color(0xFFDFEFF7),
      'accent': Color(0xFF0284C7),
      'desc': 'Explore sunny, rainy, cloudy days and four seasons!',
    },
    {
      'emoji': '🍎',
      'title': 'Fruits & Vegetables',
      'subject': 'Health',
      'duration': '5 min',
      'lessonNo': 6,
      'done': false,
      'bg': Color(0xFFFFF3E0),
      'accent': Color(0xFFEA580C),
      'desc': 'Learn about yummy healthy foods that keep you strong!',
    },
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
              color: Colors.orange.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Icon(Icons.arrow_back_ios_rounded,
                size: 16, color: Colors.orange.shade600),
          ),
        )
            : null,
        title: Row(
          children: [
            const Text('📖', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Lessons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.orange.shade700,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.orange.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Keep going, Elne!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '2 of 6 lessons completed ⭐',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: lessons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (ctx, i) {
                  final l = lessons[i];
                  return _LessonCard(lesson: l);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class _LessonCard extends StatelessWidget {
  final Map<String, dynamic> lesson;
  const _LessonCard({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final bool done = lesson['done'] as bool;
    final Color accent = lesson['accent'] as Color;
    final Color bg = lesson['bg'] as Color;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: accent.withOpacity(0.15), width: 1),
        ),
        child: Row(
          children: [
            // Emoji thumbnail
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text(lesson['emoji'] as String, style: const TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson['title'] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          lesson['subject'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: accent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· ${lesson['duration']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status badge
            done
                ? Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, size: 20, color: Colors.green),
            )
                : Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.play_arrow_rounded, size: 22, color: accent),
            ),
          ],
        ),
      ),
    );
  }
}