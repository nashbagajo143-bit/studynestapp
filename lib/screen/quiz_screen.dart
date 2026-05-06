import 'dart:async';
import 'package:flutter/material.dart';
import '../models/task_model.dart';

class QuizScreen extends StatefulWidget {
  final Tasks task;
  const QuizScreen({super.key, required this.task});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _currentQ = 0;
  int _secondsLeft = 0;
  Timer? _timer;
  final List<int?> _answers = [];
  bool _finished = false;
  bool _timeUp   = false;

  late AnimationController _shakeCtrl;
  late AnimationController _correctCtrl;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.task.timeLimitSeconds ?? 60;
    _answers.addAll(List.filled(widget.task.questions!.length, null));
    _startTimer();

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _correctCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft <= 1) {
        _timer?.cancel();
        setState(() {
          _timeUp   = true;
          _finished = true;
          widget.task.status = TaskStatus.sent;
        });
        _showResult();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _selectAnswer(int choiceIndex) {
    if (_answers[_currentQ] != null) return; // already answered
    setState(() => _answers[_currentQ] = choiceIndex);

    final correct = widget.task.questions![_currentQ].correctIndex;
    if (choiceIndex == correct) {
      _correctCtrl.forward(from: 0);
    } else {
      _shakeCtrl.forward(from: 0);
    }

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      if (_currentQ < widget.task.questions!.length - 1) {
        setState(() => _currentQ++);
      } else {
        _timer?.cancel();
        setState(() {
          _finished = true;
          widget.task.status = TaskStatus.sent;
        });
        _showResult();
      }
    });
  }

  int get _score => _answers.asMap().entries.where((e) {
    if (e.value == null) return false;
    return e.value == widget.task.questions![e.key].correctIndex;
  }).length;

  void _showResult() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => _ResultDialog(
          score: _score,
          total: widget.task.questions!.length,
          timeUp: _timeUp,
          onDone: () {
            Navigator.pop(context); // close dialog
            Navigator.pop(context); // back to tasks
          },
        ),
      );
    });
  }

  String get _timerLabel {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Color get _timerColor {
    if (_secondsLeft > (widget.task.timeLimitSeconds! * 0.5)) return Colors.green.shade600;
    if (_secondsLeft > (widget.task.timeLimitSeconds! * 0.25)) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeCtrl.dispose();
    _correctCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.task.questions!;
    final q         = questions[_currentQ];
    final answered  = _answers[_currentQ];
    final total     = questions.length;
    final progress  = _secondsLeft / (widget.task.timeLimitSeconds ?? 1);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(children: [
          // Question counter
          Text(
            'Q${_currentQ + 1} / $total',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
          ),
          const Spacer(),
          // ── Live countdown timer ──────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: _timerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _timerColor.withOpacity(0.3)),
            ),
            child: Row(children: [
              Icon(Icons.timer_rounded, size: 18, color: _timerColor),
              const SizedBox(width: 5),
              Text(
                _timerLabel,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: _timerColor,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ]),
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          // ── Timer progress bar ──────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey.shade200,
                color: _timerColor,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Question progress dots ──────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(total, (i) {
              Color dotColor;
              if (_answers[i] == null) {
                dotColor = i == _currentQ ? Colors.purple : Colors.grey.shade300;
              } else if (_answers[i] == questions[i].correctIndex) {
                dotColor = Colors.green.shade400;
              } else {
                dotColor = Colors.red.shade400;
              }
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _currentQ ? 24 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: dotColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }),
          ),

          const SizedBox(height: 24),

          // ── Question card ───────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade400, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(children: [
              Text(q.emoji, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 14),
              Text(
                q.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ]),
          ),

          const SizedBox(height: 24),

          // ── Choices ─────────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              itemCount: q.choices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                Color? choiceBg;
                Color? choiceBorder;
                Color? choiceText = const Color(0xFF1A1A2E);
                IconData? trailingIcon;

                if (answered != null) {
                  final isCorrect = i == q.correctIndex;
                  final isSelected = i == answered;
                  if (isCorrect) {
                    choiceBg     = Colors.green.shade50;
                    choiceBorder = Colors.green.shade400;
                    choiceText   = Colors.green.shade700;
                    trailingIcon = Icons.check_circle_rounded;
                  } else if (isSelected) {
                    choiceBg     = Colors.red.shade50;
                    choiceBorder = Colors.red.shade400;
                    choiceText   = Colors.red.shade700;
                    trailingIcon = Icons.cancel_rounded;
                  }
                }

                final labels = ['A', 'B', 'C', 'D'];

                return GestureDetector(
                  onTap: () => _selectAnswer(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: choiceBg ?? Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: choiceBorder ?? Colors.grey.shade200,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(children: [
                      // Letter badge
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: (choiceBorder ?? Colors.purple.withOpacity(0.15)).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            labels[i],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: choiceText,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          q.choices[i],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: choiceText,
                          ),
                        ),
                      ),
                      if (trailingIcon != null)
                        Icon(
                          trailingIcon,
                          color: choiceBorder,
                          size: 22,
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

// ─────────────────────────────────────────────────────────────
//  Result Dialog
// ─────────────────────────────────────────────────────────────
class _ResultDialog extends StatelessWidget {
  final int score;
  final int total;
  final bool timeUp;
  final VoidCallback onDone;

  const _ResultDialog({
    required this.score,
    required this.total,
    required this.timeUp,
    required this.onDone,
  });

  String get _emoji {
    final pct = score / total;
    if (pct == 1.0) return '🏆';
    if (pct >= 0.7) return '🌟';
    if (pct >= 0.5) return '👍';
    return '💪';
  }

  String get _message {
    final pct = score / total;
    if (timeUp && score < total) return "Time's up! You got $score/$total!";
    if (pct == 1.0) return 'Perfect Score! Amazing! 🎉';
    if (pct >= 0.7) return 'Great job! Keep it up!';
    if (pct >= 0.5) return 'Good try! Practice more!';
    return 'Keep practicing, you can do it!';
  }

  Color get _scoreColor {
    final pct = score / total;
    if (pct == 1.0) return Colors.green.shade600;
    if (pct >= 0.7) return Colors.orange.shade600;
    return Colors.red.shade500;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (timeUp)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.timer_off_rounded, size: 16, color: Colors.red.shade500),
                const SizedBox(width: 6),
                Text("Time's Up! ⏰",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.red.shade600)),
              ]),
            ),
          Text(_emoji, style: const TextStyle(fontSize: 56)),
          const SizedBox(height: 12),
          Text(
            '$score / $total',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: _scoreColor),
          ),
          const SizedBox(height: 6),
          Text(_message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: Colors.grey)),
          const SizedBox(height: 16),

          // Progress ring visual
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: score / total,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              color: _scoreColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(score / total * 100).round()}% correct',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '⭐ +${score * 5} Stars Earned!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.amber.shade700),
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              onPressed: onDone,
              child: const Text('Back to Quizzes 🏠',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
        ]),
      ),
    );
  }
}