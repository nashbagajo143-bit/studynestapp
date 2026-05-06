import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const StudyNestApp());
}

class StudyNestApp extends StatelessWidget {
  const StudyNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyNest',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const GradeSelectionScreen(),
    );
  }
}

class GradeSelectionScreen extends StatelessWidget {
  const GradeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Logo container — same 80×80 size, updated to gradient ──
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6D28D9).withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: _GraduationCapLogo(size: 60),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Title ──
                const Text(
                  'Select Your Grade',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 10),

                // ── Subtitle ──
                const Text(
                  'Choose your learning dashboard to get started.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 44),

                // ── Grades K-2 Card ──
                _GradeCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  shadowColor: const Color(0xFF6D28D9).withOpacity(0.45),
                  icon: Icons.auto_awesome_rounded,
                  grade: 'Grade 4',
                  dashboard: 'StudyNest Dashboard',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(gradeLevel: 'K-2'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ── Grades 3-6 Card ──
                _GradeCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4B8EF5), Color(0xFF3B6CF0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  shadowColor: const Color(0xFF3B6CF0).withOpacity(0.45),
                  icon: Icons.rocket_launch_rounded,
                  grade: 'K - Grade 6',
                  dashboard: 'StudyPro Dashboard',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(gradeLevel: '3-6'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Custom Graduation Cap Logo — same painter, color updated to white ──────
class _GraduationCapLogo extends StatelessWidget {
  final double size;
  const _GraduationCapLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GradCapPainter(),
    );
  }
}

class _GradCapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Changed: was Color(0xFF9B30D9), now white so it shows on gradient bg
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // ── Top flat diamond / mortarboard top ──
    final topPath = Path();
    topPath.moveTo(w * 0.50, h * 0.04);
    topPath.lineTo(w * 0.96, h * 0.30);
    topPath.lineTo(w * 0.50, h * 0.54);
    topPath.lineTo(w * 0.04, h * 0.30);
    topPath.close();
    canvas.drawPath(topPath, paint);

    // ── Lower body (trapezoid body of cap) ──
    final bodyPath = Path();
    bodyPath.moveTo(w * 0.17, h * 0.40);
    bodyPath.lineTo(w * 0.50, h * 0.60);
    bodyPath.lineTo(w * 0.83, h * 0.40);
    bodyPath.lineTo(w * 0.83, h * 0.67);
    bodyPath.lineTo(w * 0.50, h * 0.88);
    bodyPath.lineTo(w * 0.17, h * 0.67);
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // ── Tassel stem ──
    final tasselRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.88, h * 0.26, w * 0.08, h * 0.40),
      const Radius.circular(4),
    );
    canvas.drawRRect(tasselRect, paint);

    // ── White V notch — changed to semi-transparent white ──
    final notchPaint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..style = PaintingStyle.fill;

    final notchPath = Path();
    notchPath.moveTo(w * 0.50, h * 0.62);
    notchPath.lineTo(w * 0.76, h * 0.48);
    notchPath.lineTo(w * 0.76, h * 0.54);
    notchPath.lineTo(w * 0.50, h * 0.70);
    notchPath.lineTo(w * 0.24, h * 0.54);
    notchPath.lineTo(w * 0.24, h * 0.48);
    notchPath.close();
    canvas.drawPath(notchPath, notchPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Grade Card Widget — completely unchanged ───────────────────────────────
class _GradeCard extends StatelessWidget {
  final LinearGradient gradient;
  final Color shadowColor;
  final IconData icon;
  final String grade;
  final String dashboard;
  final VoidCallback onTap;

  const _GradeCard({
    required this.gradient,
    required this.shadowColor,
    required this.icon,
    required this.grade,
    required this.dashboard,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Icon badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    dashboard,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}