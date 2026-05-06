import 'package:flutter/material.dart';
import 'nav/profile_page1.dart';
import 'screen/learning_materials1_page.dart';
import 'widgets/review_tasks1_page.dart';
import 'widgets/achievements1_page.dart';
import 'screen/tasks_screen1.dart';
import 'EduGames/Lesson_games_page.dart';
class DashboardKinder extends StatelessWidget {
  const DashboardKinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyNest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardKinder(),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TasksScreen1(),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LessonGamesPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen1(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FB),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF5B6AF5),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_turned_in_rounded),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_esports),
                label: 'Edugames',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header Card with new SVG-converted logo ──────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // ── NEW logo: gradient box + SVG-converted icon ──
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6D28D9).withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: _StudyNestLogo(size: 32),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'StudyNest',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Welcome Card ────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2A44),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E2A44).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back, Nash!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _statsCard(
                            title: 'Weekly Goal',
                            value: '80%',
                            showProgress: true,
                            progress: 0.8,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statsCard(
                            title: 'Tasks',
                            value: '2 Due',
                            showProgress: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Current Activity Card ────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFB3D9F5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            'https://api.dicebear.com/9.x/bottts/png?seed=Nolan',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80,
                              height: 80,
                              color: const Color(0xFFE8F4FD),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Learning Materials',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5B6AF5),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Jump back into your learning modules.',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LearningMaterialsPage1(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.show_chart_rounded, size: 18),
                        label: const Text(
                          'View Lesson',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _featureCard(
                backgroundColor: Colors.white,
                borderColor: const Color(0xFFE0E0E0),
                imageUrl:
                'https://api.dicebear.com/7.x/bottts/png?seed=clock&backgroundColor=ffdfbf',
                title: 'Review Tasks',
                subtitle: 'Review your completed Tasks & scores.',
                buttonLabel: 'View History',
                buttonIcon: Icons.history_rounded,
                buttonColor: const Color(0xFF3D4A6B),
                titleColor: const Color(0xFF1A1A2E),
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PastTasksPage1(completedTasks: []),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              _featureCard(
                backgroundColor: const Color(0xFFE0FAF4),
                borderColor: const Color(0xFF7DDFC3),
                imageUrl:
                'https://api.dicebear.com/7.x/bottts/png?seed=assign&backgroundColor=c0efff',
                title: 'Tasks',
                subtitle: 'Check your upcoming homework.',
                buttonLabel: 'Open Tasks',
                buttonIcon: Icons.task_alt_rounded,
                buttonColor: const Color(0xFF1DAA7A),
                titleColor: const Color(0xFF1A1A2E),
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TasksScreen1(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              _featureCard(
                backgroundColor: const Color(0xFFF5EEFF),
                borderColor: const Color(0xFFD4AAFF),
                imageUrl:
                'https://api.dicebear.com/7.x/bottts/png?seed=books&backgroundColor=ffd5ec',
                title: 'Achievements',
                subtitle: 'You can view achievements anytime.',
                buttonLabel: 'View Achievements',
                buttonIcon: Icons.play_circle_outline_rounded,
                buttonColor: const Color(0xFF8B5CF6),
                titleColor: const Color(0xFF6B21A8),
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AchievementsScreen1(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              _featureCard(
                backgroundColor: const Color(0xFFFFF7ED),
                borderColor: const Color(0xFFF59E0B),
                imageUrl: 'https://api.dicebear.com/7.x/bottts/png?seed=games&backgroundColor=fff3cd',
                title: 'Learning Games',
                subtitle: 'Fun educational games to boost learning.',
                buttonLabel: 'Play Games',
                buttonIcon: Icons.videogame_asset_rounded,
                buttonColor: const Color(0xFFEA580C),
                titleColor: const Color(0xFFB45309),
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LessonGamesPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _statsCard({
    required String title,
    required String value,
    required bool showProgress,
    double progress = 0.0,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  color: Color(0xFF4ADE80),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          if (showProgress) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF4ADE80),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _featureCard({
    required Color backgroundColor,
    required Color borderColor,
    required String imageUrl,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required IconData buttonIcon,
    required Color buttonColor,
    required Color titleColor,
    VoidCallback? onButtonPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
              color: borderColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                color: borderColor.withOpacity(0.3),
                child: Icon(buttonIcon, color: buttonColor, size: 36),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: titleColor)),
                const SizedBox(height: 5),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.black54, fontSize: 12, height: 1.4)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: onButtonPressed,
                    icon: Icon(buttonIcon, size: 16),
                    label: Text(buttonLabel,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  NEW Logo — converted from the SVG graduation cap icon
//
//  Original SVG paths:
//    <path d="M12 3L1 9l11 6 9-4.91V17h2V9L12 3z" fill="white"/>
//    <path d="M5 13.18v4L12 21l7-3.82v-4L12 17l-7-3.82z"
//          fill="white" opacity="0.8"/>
//
//  viewBox: 0 0 24 24  →  we normalise to 0..1 then scale to [size].
// ─────────────────────────────────────────────────────────────
class _StudyNestLogo extends StatelessWidget {
  final double size;
  const _StudyNestLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _StudyNestLogoPainter(),
    );
  }
}

class _StudyNestLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Scale factor: SVG viewBox is 24×24
    final double sx = size.width / 24;
    final double sy = size.height / 24;

    // ── Top layer: mortarboard top + tassel pole (opacity 1.0, white) ──
    final paintTop = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Path 1 — "M12 3L1 9l11 6 9-4.91V17h2V9L12 3z"
    final path1 = Path();
    path1.moveTo(12 * sx, 3 * sy);
    path1.lineTo(1 * sx, 9 * sy);
    path1.lineTo(12 * sx, 15 * sy);
    path1.lineTo(21 * sx, 10.09 * sy); // 9-4.91 = point before V17
    path1.lineTo(21 * sx, 17 * sy);    // V17
    path1.lineTo(23 * sx, 17 * sy);    // h2
    path1.lineTo(23 * sx, 9 * sy);     // V9
    path1.lineTo(12 * sx, 3 * sy);     // back to start
    path1.close();
    canvas.drawPath(path1, paintTop);

    // ── Bottom layer: body of mortarboard (opacity 0.8, white) ──
    final paintBody = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    // Path 2 — "M5 13.18v4L12 21l7-3.82v-4L12 17l-7-3.82z"
    final path2 = Path();
    path2.moveTo(5 * sx, 13.18 * sy);
    path2.lineTo(5 * sx, 17.18 * sy);   // v4
    path2.lineTo(12 * sx, 21 * sy);     // L12 21
    path2.lineTo(19 * sx, 17.18 * sy);  // l7-3.82
    path2.lineTo(19 * sx, 13.18 * sy);  // v-4
    path2.lineTo(12 * sx, 17 * sy);     // L12 17
    path2.lineTo(5 * sx, 13.18 * sy);   // l-7-3.82 (close)
    path2.close();
    canvas.drawPath(path2, paintBody);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}