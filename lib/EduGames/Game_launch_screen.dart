import 'package:flutter/material.dart';
import 'package:mystudynestflutter/models/Lesson_game_model.dart';

class GameLaunchScreen extends StatefulWidget {
  final LessonGame game;
  const GameLaunchScreen({super.key, required this.game});

  @override
  State<GameLaunchScreen> createState() => _GameLaunchScreenState();
}

class _GameLaunchScreenState extends State<GameLaunchScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;
  int _score = 0;
  bool _gameStarted = false;
  bool _gameFinished = false;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.95, end: 1.05)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _startGame() => setState(() => _gameStarted = true);

  void _addScore(int pts) {
    setState(() => _score += pts);
    if (_score >= 30) setState(() => _gameFinished = true);
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close_rounded,
                size: 18, color: Color(0xFF1A1A2E)),
          ),
        ),
        title: Text(
          game.gameTitle,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E)),
        ),
        actions: [
          if (_gameStarted && !_gameFinished)
            Container(
              margin: const EdgeInsets.only(right: 14, top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star_rounded,
                      size: 16, color: Color(0xFFF59E0B)),
                  const SizedBox(width: 4),
                  Text('$_score pts',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Color(0xFF92400E))),
                ],
              ),
            ),
        ],
      ),
      body: _gameFinished
          ? _buildResult(game)
          : !_gameStarted
          ? _buildIntro(game)
          : _buildGame(game),
    );
  }

  Widget _buildIntro(LessonGame game) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Avatar
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, child) =>
                Transform.scale(scale: _pulse.value, child: child),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                game.gameImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [game.gameColor, game.gameColor.withOpacity(0.7)]),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(game.gameIcon, size: 72, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text(game.gameTitle,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: game.gameColor)),
          const SizedBox(height: 8),
          Text(game.gameDescription,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),

          const SizedBox(height: 24),

          // Stats row
          Row(children: [
            _StatBox('🏆', 'Best Score', '${game.highScore}', game.gameColor),
            const SizedBox(width: 12),
            _StatBox('⏱️', 'Best Time', game.bestTime, game.gameColor),
            const SizedBox(width: 12),
            _StatBox('⭐', 'Level', '${game.level}', game.gameColor),
          ]),

          const SizedBox(height: 28),

          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: game.gameColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: game.gameColor.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Paano Maglaro:',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: game.gameColor)),
                const SizedBox(height: 8),
                _instruction('1️⃣', 'Basahin ang bawat tanong nang mabuti.'),
                _instruction('2️⃣', 'Piliin ang tamang sagot bago mag-timeout.'),
                _instruction(
                    '3️⃣', 'Kumita ng puntos para sa bawat tamang sagot!'),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Start button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [game.gameColor, game.gameColor.withOpacity(0.8)]),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: game.gameColor.withOpacity(0.45),
                      blurRadius: 16,
                      offset: const Offset(0, 8))
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: _startGame,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 26),
                      SizedBox(width: 8),
                      Text('Simulan ang Laro!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGame(LessonGame game) {
    // Demo game: tap buttons to score points
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Score bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [game.gameColor, game.gameColor.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Score:',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text('$_score / 30',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _score / 30,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              color: game.gameColor,
            ),
          ),
          const SizedBox(height: 30),

          Text('Sagutin ang tanong:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700)),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [game.gameColor, game.gameColor.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Ano ang kailangan mo para mabuti ang iyong Filipino?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 20),

          // Answer choices
          ...[
            ('Pag-aaral at pagsasanay', true),
            ('Tulog na lang', false),
            ('Huwag nang basahin', false),
            ('Maglaro ng video games', false),
          ].map((opt) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => _addScore(opt.$2 ? 10 : 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: game.gameColor.withOpacity(0.2), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Text(opt.$1,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E))),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResult(LessonGame game) {
    final bool perfect = _score >= 30;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(perfect ? '🏆' : '⭐',
                style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(perfect ? 'Perpekto!' : 'Magaling!',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: game.gameColor)),
            const SizedBox(height: 8),
            Text('Score mo: $_score puntos',
                style: const TextStyle(
                    fontSize: 18, color: Color(0xFF4B5563))),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Column(
                children: [
                  const Text('⭐ Stars Earned!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF92400E))),
                  const SizedBox(height: 4),
                  Text('+${_score ~/ 3} stars',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.amber.shade600)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: game.gameColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context); // back to lesson review
                  Navigator.pop(context); // back to games list
                },
                child: const Text('Bumalik sa Aralin',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _instruction(String emoji, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 13, color: Color(0xFF4B5563)))),
      ],
    ),
  );
}

class _StatBox extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color color;
  const _StatBox(this.emoji, this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w900, color: color)),
          Text(label,
              style: const TextStyle(
                  fontSize: 10, color: Color(0xFF9A9AB0))),
        ],
      ),
    ),
  );
}