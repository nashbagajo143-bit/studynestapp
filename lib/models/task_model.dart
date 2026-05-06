import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
//  Enums
// ─────────────────────────────────────────────────────────────
enum AnswerType { typeOnly, photoOnly, both }
enum TaskStatus { pending, inProgress, sent }
enum TaskType   { assignment, quiz }

// ─────────────────────────────────────────────────────────────
//  Task model
// ─────────────────────────────────────────────────────────────
class Tasks {
  final String    id;
  final String    title;
  final String    description;
  final String    teacher;
  final DateTime  deadline;       // replaces dueDate string → real DateTime
  final String    subject;
  final Color     color;
  final IconData  icon;
  final AnswerType answerType;
  final TaskType  taskType;
  final int?      timeLimitSeconds; // only for quiz (null = no limit)
  final List<QuizQuestion>? questions; // only for quiz
  TaskStatus status;

  Tasks({
    required this.id,
    required this.title,
    required this.description,
    required this.teacher,
    required this.deadline,
    required this.subject,
    required this.color,
    required this.icon,
    required this.answerType,
    required this.taskType,
    this.timeLimitSeconds,
    this.questions,
    this.status = TaskStatus.pending,
  });

  /// Returns human-readable deadline label + urgency level 0-2
  DeadlineInfo get deadlineInfo {
    final now  = DateTime.now();
    final diff = deadline.difference(now);

    if (diff.isNegative) {
      return DeadlineInfo(label: 'Overdue!', level: 2);
    } else if (diff.inHours < 24) {
      final h = diff.inHours;
      final m = diff.inMinutes % 60;
      return DeadlineInfo(
        label: h > 0 ? '${h}h ${m}m left' : '${m}m left',
        level: 2,
      );
    } else if (diff.inDays == 1) {
      return DeadlineInfo(label: 'Due Tomorrow', level: 1);
    } else {
      return DeadlineInfo(label: 'Due in ${diff.inDays} days', level: 0);
    }
  }

  /// Percentage of time remaining (1.0 = full, 0.0 = expired) — for progress bar on card
  double get deadlineProgress {
    // We show based on urgency: within 24 h → show countdown progress
    final now  = DateTime.now();
    final diff = deadline.difference(now);
    if (diff.isNegative) return 0.0;
    if (diff.inHours >= 48) return 1.0;
    // interpolate between 0–48 h
    return (diff.inMinutes / (48 * 60)).clamp(0.0, 1.0);
  }
}

class DeadlineInfo {
  final String label;
  final int level; // 0 = safe, 1 = soon, 2 = urgent/overdue
  const DeadlineInfo({required this.label, required this.level});
}

// ─────────────────────────────────────────────────────────────
//  Quiz question model
// ─────────────────────────────────────────────────────────────
class QuizQuestion {
  final String question;
  final List<String> choices;
  final int correctIndex;
  final String emoji;

  const QuizQuestion({
    required this.question,
    required this.choices,
    required this.correctIndex,
    required this.emoji,
  });
}

// ─────────────────────────────────────────────────────────────
//  Sample data
// ─────────────────────────────────────────────────────────────
final List<Tasks> sampleTasks = [
  // ── ASSIGNMENTS ──────────────────────────────────────────
  Tasks(
    id: 'a1',
    taskType: TaskType.assignment,
    title: 'Match the Shapes',
    description: 'Draw lines to match the shapes that are the same! Use your pencil carefully.',
    teacher: 'Ms. Sarah',
    deadline: DateTime.now().add(const Duration(hours: 3)),
    subject: 'Shapes',
    color: const Color(0xFFD8C8F0),
    icon: Icons.category_outlined,
    answerType: AnswerType.photoOnly,
    status: TaskStatus.sent,
  ),
  Tasks(
    id: 'a2',
    taskType: TaskType.assignment,
    title: 'Count the Stars',
    description: 'Count all the stars on the page and write the number in the box.',
    teacher: 'Mr. John',
    deadline: DateTime.now().add(const Duration(hours: 8)),
    subject: 'Math',
    color: const Color(0xFFBFD8F7),
    icon: Icons.calculate_outlined,
    answerType: AnswerType.typeOnly,
    status: TaskStatus.inProgress,
  ),
  Tasks(
    id: 'a3',
    taskType: TaskType.assignment,
    title: 'ABC Practice',
    description: 'Write the alphabet from A to Z in your notebook. Make each letter big and clear!',
    teacher: 'Ms. Sarah',
    deadline: DateTime.now().add(const Duration(days: 2)),
    subject: 'Reading',
    color: const Color(0xFFB8F0D8),
    icon: Icons.menu_book_outlined,
    answerType: AnswerType.both,
    status: TaskStatus.pending,
  ),
  Tasks(
    id: 'a4',
    taskType: TaskType.assignment,
    title: 'Draw the Numbers',
    description: 'Draw and color the numbers 1 to 10. Use your favorite colors!',
    teacher: 'Ms. Sarah',
    deadline: DateTime.now().add(const Duration(days: 3)),
    subject: 'Writing',
    color: const Color(0xFFFFF0A0),
    icon: Icons.edit_outlined,
    answerType: AnswerType.photoOnly,
    status: TaskStatus.pending,
  ),
  Tasks(
    id: 'a5',
    taskType: TaskType.assignment,
    title: 'Favorite Color',
    description: 'What is your favorite color? Write 2 sentences about why you love it!',
    teacher: 'Mr. John',
    deadline: DateTime.now().add(const Duration(days: 4)),
    subject: 'Fun',
    color: const Color(0xFFFFB8D0),
    icon: Icons.article_outlined,
    answerType: AnswerType.typeOnly,
    status: TaskStatus.pending,
  ),

  // ── QUIZZES ───────────────────────────────────────────────
  Tasks(
    id: 'q1',
    taskType: TaskType.quiz,
    title: 'Shapes Quiz 🔷',
    description: 'Test what you know about shapes! Answer all questions before time runs out.',
    teacher: 'Ms. Sarah',
    deadline: DateTime.now().add(const Duration(hours: 5)),
    subject: 'Shapes',
    color: const Color(0xFFFFD8B8),
    icon: Icons.quiz_outlined,
    answerType: AnswerType.typeOnly,
    timeLimitSeconds: 120, // 2 minutes
    status: TaskStatus.pending,
    questions: const [
      QuizQuestion(
        question: 'Which shape has 3 sides?',
        choices: ['Circle', 'Triangle', 'Square', 'Rectangle'],
        correctIndex: 1,
        emoji: '🔺',
      ),
      QuizQuestion(
        question: 'Which shape has 4 equal sides?',
        choices: ['Rectangle', 'Triangle', 'Square', 'Oval'],
        correctIndex: 2,
        emoji: '🟥',
      ),
      QuizQuestion(
        question: 'Which shape is round?',
        choices: ['Square', 'Triangle', 'Circle', 'Diamond'],
        correctIndex: 2,
        emoji: '⭕',
      ),
      QuizQuestion(
        question: 'How many sides does a rectangle have?',
        choices: ['3', '5', '6', '4'],
        correctIndex: 3,
        emoji: '📐',
      ),
    ],
  ),
  Tasks(
    id: 'q2',
    taskType: TaskType.quiz,
    title: 'Numbers Quiz 🔢',
    description: 'How well do you know your numbers? Let\'s find out!',
    teacher: 'Mr. John',
    deadline: DateTime.now().add(const Duration(days: 1)),
    subject: 'Math',
    color: const Color(0xFFC8E6FF),
    icon: Icons.quiz_outlined,
    answerType: AnswerType.typeOnly,
    timeLimitSeconds: 90, // 1.5 minutes
    status: TaskStatus.pending,
    questions: const [
      QuizQuestion(
        question: 'What comes after 7?',
        choices: ['6', '9', '8', '10'],
        correctIndex: 2,
        emoji: '7️⃣',
      ),
      QuizQuestion(
        question: 'How many fingers do we have on one hand?',
        choices: ['4', '5', '6', '3'],
        correctIndex: 1,
        emoji: '✋',
      ),
      QuizQuestion(
        question: 'Which number is the biggest?',
        choices: ['3', '7', '1', '9'],
        correctIndex: 3,
        emoji: '🔢',
      ),
    ],
  ),
  Tasks(
    id: 'q3',
    taskType: TaskType.quiz,
    title: 'ABC Quiz 🔤',
    description: 'Test your knowledge of the alphabet!',
    teacher: 'Ms. Sarah',
    deadline: DateTime.now().add(const Duration(days: 5)),
    subject: 'Reading',
    color: const Color(0xFFD0F5C8),
    icon: Icons.quiz_outlined,
    answerType: AnswerType.typeOnly,
    timeLimitSeconds: 60, // 1 minute
    status: TaskStatus.sent,
    questions: const [
      QuizQuestion(
        question: 'Which letter comes after B?',
        choices: ['A', 'D', 'C', 'E'],
        correctIndex: 2,
        emoji: '🔤',
      ),
      QuizQuestion(
        question: 'What is the first letter of the alphabet?',
        choices: ['B', 'A', 'C', 'Z'],
        correctIndex: 1,
        emoji: '🅰️',
      ),
    ],
  ),
];

List<Tasks> get sampleAssignments =>
    sampleTasks.where((t) => t.taskType == TaskType.assignment).toList();

List<Tasks> get sampleQuizzes =>
    sampleTasks.where((t) => t.taskType == TaskType.quiz).toList();