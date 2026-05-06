import 'package:flutter/material.dart';
import 'package:mystudynestflutter/dashboard_kinder.dart';
import 'package:mystudynestflutter/nav/profile_page1.dart';
import 'package:mystudynestflutter/screen/tasks_screen1.dart';
import 'package:mystudynestflutter/models/Lesson_game_model.dart';
import 'Lesson_review_screen.dart';
class LessonGamesPage extends StatefulWidget {
  const LessonGamesPage({super.key});

  @override
  State<LessonGamesPage> createState() => _LessonGamesPageState();
}

class _LessonGamesPageState extends State<LessonGamesPage> {
  int _selectedIndex = 2;
  int _selectedYunit = 0; // which unit tab is active

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const DashboardKinder()));
    } else if (index == 1) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const TasksScreen1()));
    } else if (index == 2) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const LessonGamesPage()));
    } else if (index == 3) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const ProfileScreen1()));
    }
  }

  // Count lessons with games per yunit
  int _gamesCount(Yunit y) => y.lessons.where((l) => l.hasGame).length;

  @override
  Widget build(BuildContext context) {
    final yunit = allYunits[_selectedYunit];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardKinder()),
          ),
        ),
        title: const Text(
          'EduGames',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF1A1A2E)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        actions: [
          // Star badge
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.star_rounded, color: Color(0xFF1A1A2E)),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFC107), shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text('3',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, -4))
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF5B6AF5),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_turned_in_rounded),
                  label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_esports), label: 'Edugames'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded), label: 'Profile'),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Unit Tabs ───────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select a Unit',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9A9AB0))),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(allYunits.length, (i) {
                      final y = allYunits[i];
                      final selected = i == _selectedYunit;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedYunit = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: selected
                                ? const LinearGradient(
                              colors: [
                                Color(0xFF7C3AED),
                                Color(0xFF6D28D9)
                              ],
                            )
                                : null,
                            color: selected ? null : const Color(0xFFF0F0F5),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: selected
                                ? [
                              BoxShadow(
                                color: const Color(0xFF6D28D9)
                                    .withOpacity(0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]
                                : [],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Yunit ${y.number}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xFF1A1A2E),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${_gamesCount(y)} games',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: selected
                                      ? Colors.white70
                                      : const Color(0xFF9A9AB0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // ── Unit title ──────────────────────────────────────────
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Text(
              yunit.title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4C1D95)),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // ── Lessons list ────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: yunit.lessons.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                final aralin = yunit.lessons[i];
                return _AralinCard(
                  yunitNumber: yunit.number,
                  aralin: aralin,
                  onTap: () => Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (_) => LessonReviewScreen(
                        yunitNumber: yunit.number,
                        yunitTitle: yunit.title,
                        aralin: aralin,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Aralin Card
// ─────────────────────────────────────────────────────────────
class _AralinCard extends StatelessWidget {
  final int yunitNumber;
  final Aralin aralin;
  final VoidCallback onTap;

  const _AralinCard({
    required this.yunitNumber,
    required this.aralin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasGame = aralin.hasGame;
    final Color accentColor =
    hasGame ? aralin.game!.gameColor : const Color(0xFF9A9AB0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hasGame ? accentColor.withOpacity(0.3) : const Color(0xFFEEEEEE),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: hasGame
                  ? accentColor.withOpacity(0.12)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // ── Aralin number badge ─────────────────────────────
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: hasGame
                      ? accentColor.withOpacity(0.12)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${aralin.number}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: hasGame ? accentColor : const Color(0xFFBBBBBB),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // ── Info ────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aralin ${aralin.number}',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9A9AB0)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      aralin.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E)),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        aralin.topic,
                        style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9A9AB0),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // ── Right badge ─────────────────────────────────────
              Column(
                children: [
                  if (hasGame)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: accentColor.withOpacity(0.3), width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sports_esports_rounded,
                              size: 12, color: accentColor),
                          const SizedBox(width: 3),
                          Text('Game',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: accentColor)),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Lesson only',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFBBBBBB),
                              fontWeight: FontWeight.w500)),
                    ),
                  const SizedBox(height: 6),
                  Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: Colors.grey.shade300),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}