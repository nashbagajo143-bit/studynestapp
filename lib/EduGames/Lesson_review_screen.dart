import 'package:flutter/material.dart';
import 'package:mystudynestflutter/models/Lesson_game_model.dart';
import 'package:mystudynestflutter/EduGames//Game_launch_screen.dart';
class LessonReviewScreen extends StatefulWidget {
  final int yunitNumber;
  final String yunitTitle;
  final Aralin aralin;

  const LessonReviewScreen({
    super.key,
    required this.yunitNumber,
    required this.yunitTitle,
    required this.aralin,
  });

  @override
  State<LessonReviewScreen> createState() => _LessonReviewScreenState();
}

class _LessonReviewScreenState extends State<LessonReviewScreen> {
  bool _hasScrolledToBottom = false;
  bool _quizPassed = false;
  final ScrollController _scrollCtrl = ScrollController();

  // Mini-quiz — 2 simple comprehension questions
  int _quizStep = 0; // 0=not started, 1=q1, 2=q2, 3=done
  int? _q1Answer;
  int? _q2Answer;

  static const _questions = [
    {
      'q': 'Bakit mahalaga ang araling ito?',
      'options': [
        'Para makapag-laro lang',
        'Para mapaunlad ang ating kaalaman sa Filipino',
        'Para matulog nang maagang',
        'Para kumain ng merienda',
      ],
      'correct': 1,
    },
    {
      'q': 'Ano ang dapat gawin pagkatapos ng aralin?',
      'options': [
        'Kalimutan ang lahat',
        'I-practice ang natutuhan',
        'Huwag nang mag-aral',
        'Maglaro ng ibang laro',
      ],
      'correct': 1,
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 60) {
        if (!_hasScrolledToBottom) {
          setState(() => _hasScrolledToBottom = true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _startQuiz() => setState(() => _quizStep = 1);

  void _answerQ1(int idx) {
    setState(() {
      _q1Answer = idx;
      if (idx == _questions[0]['correct']) {
        Future.delayed(const Duration(milliseconds: 500),
                () => setState(() => _quizStep = 2));
      }
    });
  }

  void _answerQ2(int idx) {
    setState(() {
      _q2Answer = idx;
      if (idx == _questions[1]['correct']) {
        Future.delayed(
            const Duration(milliseconds: 500),
                () => setState(() {
              _quizStep = 3;
              _quizPassed = true;
            }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final aralin = widget.aralin;
    final hasGame = aralin.hasGame;
    final game = aralin.game;

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
            child: const Icon(Icons.arrow_back_ios_rounded,
                size: 16, color: Color(0xFF1A1A2E)),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yunit ${widget.yunitNumber}',
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9A9AB0),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Aralin ${aralin.number}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E)),
            ),
          ],
        ),
        actions: [
          if (hasGame)
            Container(
              margin: const EdgeInsets.only(right: 14, top: 10, bottom: 10),
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: game!.gameColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: game.gameColor.withOpacity(0.3), width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.sports_esports_rounded,
                      size: 14, color: game.gameColor),
                  const SizedBox(width: 4),
                  Text('Has Game!',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: game.gameColor)),
                ],
              ),
            ),
        ],
      ),
      body: ListView(
        controller: _scrollCtrl,
        padding: const EdgeInsets.all(16),
        children: [
          // ── Lesson header card ────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6D28D9).withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    aralin.topic,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  aralin.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1.3),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pahina ${aralin.page}',
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Read First notice ─────────────────────────────────
          if (hasGame && !_quizPassed)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  const Text('📖', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Basahin muna ang aralin. Pagkatapos ay sumagot sa maikling pagsubok bago mo ma-unlock ang laro!',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF92400E)),
                    ),
                  ),
                ],
              ),
            ),

          // ── Lesson content ────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Text('📚', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  const Text('Layunin ng Aralin',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E))),
                ]),
                const SizedBox(height: 12),
                Text(
                  aralin.content,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4B5563),
                      height: 1.7),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),

                // Extended lesson content block
                Row(children: [
                  const Text('✏️', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  const Text('Pangunahing Konsepto',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E))),
                ]),
                const SizedBox(height: 12),
                _conceptBlock(
                  'Kahulugan',
                  'Ang ${aralin.topic} ay isa sa mga mahalagang bahagi ng Filipino na dapat nating matutunan at magamit nang wasto sa ating pang-araw-araw na buhay.',
                ),
                const SizedBox(height: 12),
                _conceptBlock(
                  'Halimbawa',
                  'Makikita ang ${aralin.topic} sa iba\'t ibang bahagi ng pangungusap. Mahalaga na maunawaan natin ang kanilang papel upang makapag-communicate nang epektibo.',
                ),
                const SizedBox(height: 12),
                _conceptBlock(
                  'Paano Gamitin',
                  'Sa pagsusulat at pakikipag-usap, ginagamit natin ang ${aralin.topic} upang maging malinaw at tamang maiparating ang ating mga kaisipan.',
                ),
                const SizedBox(height: 16),

                // Scroll prompt
                if (!_hasScrolledToBottom)
                  Center(
                    child: Column(
                      children: [
                        const Divider(),
                        const SizedBox(height: 8),
                        Text('⬇️ Mag-scroll pababa upang matapos ang pagbabasa',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Mini quiz section ─────────────────────────────────
          if (_hasScrolledToBottom && !_quizPassed && hasGame) ...[
            if (_quizStep == 0) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF7C3AED).withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  children: [
                    const Text('🎯', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 8),
                    const Text('Pagsubok bago Maglaro!',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E))),
                    const SizedBox(height: 6),
                    Text('Sagutin ang 2 tanong upang ma-unlock ang laro.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade500)),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C3AED),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        onPressed: _startQuiz,
                        child: const Text('Simulan ang Pagsubok',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (_quizStep == 1) ...[
              _QuizCard(
                questionNumber: 1,
                question: _questions[0]['q'] as String,
                options: _questions[0]['options'] as List<String>,
                selectedIndex: _q1Answer,
                correctIndex: _questions[0]['correct'] as int,
                onAnswer: _answerQ1,
              ),
            ] else if (_quizStep == 2) ...[
              _QuizCard(
                questionNumber: 2,
                question: _questions[1]['q'] as String,
                options: _questions[1]['options'] as List<String>,
                selectedIndex: _q2Answer,
                correctIndex: _questions[1]['correct'] as int,
                onAnswer: _answerQ2,
              ),
            ],
          ],

          // ── Quiz passed / no game / game unlock ───────────────
          if (_quizPassed || !hasGame) ...[
            const SizedBox(height: 8),

            if (_quizPassed)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    const Text('✅', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Napasa mo ang pagsubok! Na-unlock na ang laro. Mag-enjoy!',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF065F46),
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Game card ───────────────────────────────────────
            if (hasGame)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                      color: game!.gameColor.withOpacity(0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                        color: game.gameColor.withOpacity(0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 6))
                  ],
                ),
                child: Column(
                  children: [
                    // Avatar
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22)),
                      child: Image.network(
                        game.gameImage,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 140,
                          color: game.gameColor.withOpacity(0.15),
                          child: Center(
                              child: Icon(game.gameIcon,
                                  size: 56, color: game.gameColor)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(game.gameTitle,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1A1A2E))),
                          const SizedBox(height: 4),
                          Text(game.gameDescription,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500)),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              _statChip('🏆', 'Best', '${game.highScore}',
                                  game.gameColor),
                              const SizedBox(width: 10),
                              _statChip('⏱️', 'Time', game.bestTime,
                                  game.gameColor),
                              const SizedBox(width: 10),
                              _statChip('⭐', 'Level', '${game.level}',
                                  game.gameColor),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    game.gameColor,
                                    game.gameColor.withOpacity(0.8)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                      game.gameColor.withOpacity(0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6))
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            GameLaunchScreen(game: game)),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.play_arrow_rounded,
                                          color: Colors.white, size: 24),
                                      SizedBox(width: 8),
                                      Text('Maglaro Na!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 0.5)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
            // No game message
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  children: [
                    const Text('📝', style: TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    const Text('Walang Laro para sa Araling Ito',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E))),
                    const SizedBox(height: 6),
                    Text(
                      'Ang araling ito ay nakatuon sa pagbabasa at pagsulat. Subukan ang ibang aralin na may kasamang laro!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _conceptBlock(String label, String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDE9FE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF7C3AED))),
          const SizedBox(height: 6),
          Text(text,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF4B5563), height: 1.6)),
        ],
      ),
    );
  }

  Widget _statChip(String emoji, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(value,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color)),
            Text(label,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF9A9AB0))),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Quiz Card
// ─────────────────────────────────────────────────────────────
class _QuizCard extends StatelessWidget {
  final int questionNumber;
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final int correctIndex;
  final void Function(int) onAnswer;

  const _QuizCard({
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.correctIndex,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Tanong $questionNumber',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ),
          ]),
          const SizedBox(height: 12),
          Text(question,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E))),
          const SizedBox(height: 14),
          ...List.generate(options.length, (i) {
            Color? bg;
            Color? border;
            if (selectedIndex != null) {
              if (i == correctIndex) {
                bg = Colors.green.shade50;
                border = Colors.green.shade400;
              } else if (i == selectedIndex && i != correctIndex) {
                bg = Colors.red.shade50;
                border = Colors.red.shade300;
              }
            }
            return GestureDetector(
              onTap: selectedIndex == null ? () => onAnswer(i) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: bg ?? const Color(0xFFF9F8FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: border ?? const Color(0xFFEDE9FE), width: 1.5),
                ),
                child: Row(children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: (border ?? const Color(0xFF7C3AED))
                          .withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                            ['A', 'B', 'C', 'D'][i],
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: border ?? const Color(0xFF7C3AED)))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(options[i],
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFF1A1A2E)))),
                  if (selectedIndex != null && i == correctIndex)
                    const Icon(Icons.check_circle_rounded,
                        color: Colors.green, size: 20),
                  if (selectedIndex != null &&
                      i == selectedIndex &&
                      i != correctIndex)
                    const Icon(Icons.cancel_rounded,
                        color: Colors.red, size: 20),
                ]),
              ),
            );
          }),
          if (selectedIndex != null && selectedIndex != correctIndex)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Subukan muli! Piliin ang tamang sagot.',
                  style: TextStyle(
                      color: Colors.red.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }
}