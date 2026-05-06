import 'package:flutter/material.dart';
import 'GradeSelection_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Logo: same 100 size as original Icon ───────────────
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6D28D9).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: _StudyNestLogo(size: 60),
                ),
              ),

              SizedBox(height: 20),
              Text("StudyNest", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text("Learn With Fun", style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 40),

              // ── Get Started: same ElevatedButton, just gradient color
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ).copyWith(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudyNestApp()),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6D28D9).withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Logo painter (same as dashboard) ─────────────────────────
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
    final double sx = size.width / 24;
    final double sy = size.height / 24;

    // Path 1 — top of mortarboard (full white)
    final paintTop = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(12 * sx, 3 * sy);
    path1.lineTo(1 * sx, 9 * sy);
    path1.lineTo(12 * sx, 15 * sy);
    path1.lineTo(21 * sx, 10.09 * sy);
    path1.lineTo(21 * sx, 17 * sy);
    path1.lineTo(23 * sx, 17 * sy);
    path1.lineTo(23 * sx, 9 * sy);
    path1.lineTo(12 * sx, 3 * sy);
    path1.close();
    canvas.drawPath(path1, paintTop);

    // Path 2 — body of mortarboard (white 80%)
    final paintBody = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(5 * sx, 13.18 * sy);
    path2.lineTo(5 * sx, 17.18 * sy);
    path2.lineTo(12 * sx, 21 * sy);
    path2.lineTo(19 * sx, 17.18 * sy);
    path2.lineTo(19 * sx, 13.18 * sy);
    path2.lineTo(12 * sx, 17 * sy);
    path2.lineTo(5 * sx, 13.18 * sy);
    path2.close();
    canvas.drawPath(path2, paintBody);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}