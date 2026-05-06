import 'package:flutter/material.dart';
import 'package:mystudynestflutter/dashboard_kinder.dart';
import 'package:mystudynestflutter/nav/profile_page1.dart';
import 'package:mystudynestflutter/EduGames/Lesson_games_page.dart';
import '../models/task_model.dart';
import 'assignment_detail_screen.dart';
import 'quiz_screen.dart';


class TasksScreen1 extends StatefulWidget {
  final bool showBackButton;

  const TasksScreen1({super.key, this.showBackButton = true});

  @override
  State<TasksScreen1> createState() => _TasksScreen1State();
}

class _TasksScreen1State extends State<TasksScreen1>
    with TickerProviderStateMixin {

  int _selectedIndex = 1;

  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardKinder()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TasksScreen1()),
    );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LessonGamesPage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen1()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.showBackButton
            ? GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardKinder()),
                (route) => false,
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Icon(Icons.arrow_back_ios_rounded,
                size: 16, color: Colors.teal.shade600),
          ),
        )
            : null,
        title: Row(children: const [
          Text('📋', style: TextStyle(fontSize: 22)),
          SizedBox(width: 8),
          Text(
            'Tasks',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ]),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TabBar(
              controller: _tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: const Color(0xFF1A1A2E),
              unselectedLabelColor: Colors.grey,
              labelStyle:
              const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
              unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              padding: const EdgeInsets.all(4),
              tabs: [
                Tab(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('📝', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 6),
                        Text('Assignments (${sampleAssignments.length})'),
                      ]),
                ),
                Tab(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🧠', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 6),
                        Text('Quizzes (${sampleQuizzes.length})'),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),

      // ── Bottom nav ────────────────────────────────────────
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

      body: TabBarView(
        controller: _tab,
        children: [
          _AssignmentTab(),
          _QuizTab(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Assignment Tab
// ─────────────────────────────────────────────────────────────
class _AssignmentTab extends StatelessWidget {
  final _statusOrder = const [
    TaskStatus.inProgress,
    TaskStatus.pending,
    TaskStatus.sent
  ];

  List<Tasks> get _sorted {
    final list = List<Tasks>.from(sampleAssignments);
    list.sort((a, b) => _statusOrder
        .indexOf(a.status)
        .compareTo(_statusOrder.indexOf(b.status)));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _sorted;
    final pending = tasks.where((t) => t.status != TaskStatus.sent).length;
    final submitted = tasks.where((t) => t.status == TaskStatus.sent).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(children: [
        Row(children: [
          _SummaryChip(
              label: '$pending Pending',
              color: Colors.orange.shade400,
              icon: '⏳'),
          const SizedBox(width: 10),
          _SummaryChip(
              label: '$submitted Submitted',
              color: Colors.green.shade500,
              icon: '✅'),
        ]),
        const SizedBox(height: 14),
        Expanded(
          child: ListView.separated(
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (ctx, i) => _AssignmentCard(
              task: tasks[i],
              onTap: () => Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (_) => AssignmentDetailScreen(task: tasks[i]),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Assignment Card
// ─────────────────────────────────────────────────────────────
class _AssignmentCard extends StatelessWidget {
  final Tasks task;
  final VoidCallback onTap;
  const _AssignmentCard({required this.task, required this.onTap});

  Color get _statusColor {
    switch (task.status) {
      case TaskStatus.sent:
        return Colors.green.shade500;
      case TaskStatus.inProgress:
        return Colors.orange.shade500;
      case TaskStatus.pending:
        return Colors.grey.shade400;
    }
  }

  String get _statusLabel {
    switch (task.status) {
      case TaskStatus.sent:
        return '✅ Submitted';
      case TaskStatus.inProgress:
        return '✏️ In Progress';
      case TaskStatus.pending:
        return '⏳ Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = task.deadlineInfo;
    final Color deadlineColor = [
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.red.shade600,
    ][info.level];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: task.color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: task.color.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: task.color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(task.icon,
                        size: 26, color: Colors.white.withOpacity(0.9)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: task.color.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(task.subject,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: _statusColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(_statusLabel,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: _statusColor)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(task.title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A2E))),
                          const SizedBox(height: 3),
                          Text(task.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500)),
                        ]),
                  ),
                ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
            decoration: BoxDecoration(
              color: deadlineColor.withOpacity(0.06),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.schedule_rounded, size: 14, color: deadlineColor),
                    const SizedBox(width: 5),
                    Text(info.label,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: deadlineColor)),
                  ]),
                  Row(children: [
                    Icon(Icons.person_outline_rounded,
                        size: 13, color: Colors.grey.shade400),
                    const SizedBox(width: 4),
                    Text(task.teacher,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade400)),
                  ]),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: task.deadlineProgress,
                  minHeight: 6,
                  backgroundColor: deadlineColor.withOpacity(0.15),
                  color: deadlineColor,
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Quiz Tab
// ─────────────────────────────────────────────────────────────
class _QuizTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizzes = sampleQuizzes;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade400, Colors.purple.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(children: const [
            Text('🧠', style: TextStyle(fontSize: 28)),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Quiz Time!',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15)),
              Text('Watch the timer — answer fast! ⏱️',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ]),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: ListView.separated(
            itemCount: quizzes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (ctx, i) => _QuizCard(
              task: quizzes[i],
              onTap: () {
                if (quizzes[i].status == TaskStatus.sent) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('✅ You already submitted this quiz!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                      builder: (_) => QuizScreen(task: quizzes[i])),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Quiz Card
// ─────────────────────────────────────────────────────────────
class _QuizCard extends StatelessWidget {
  final Tasks task;
  final VoidCallback onTap;
  const _QuizCard({required this.task, required this.onTap});

  String get _timeLabel {
    final s = task.timeLimitSeconds ?? 0;
    final m = s ~/ 60;
    final sec = s % 60;
    return sec == 0 ? '$m min' : '${m}m ${sec}s';
  }

  @override
  Widget build(BuildContext context) {
    final info = task.deadlineInfo;
    final bool submitted = task.status == TaskStatus.sent;

    final Color deadlineColor = submitted
        ? Colors.green.shade600
        : [
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.red.shade600,
    ][info.level];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: submitted ? Colors.grey.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: submitted ? Colors.grey.shade200 : task.color,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: task.color.withOpacity(submitted ? 0.1 : 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: submitted ? Colors.grey.shade200 : task.color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(task.icon,
                        size: 26,
                        color: submitted
                            ? Colors.grey.shade400
                            : Colors.white.withOpacity(0.9)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: submitted
                                      ? Colors.grey.shade100
                                      : task.color.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(task.subject,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color:
                                        submitted ? Colors.grey : null)),
                              ),
                              if (task.timeLimitSeconds != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: submitted
                                        ? Colors.grey.shade100
                                        : Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: submitted
                                          ? Colors.grey.shade200
                                          : Colors.red.shade200,
                                    ),
                                  ),
                                  child: Row(children: [
                                    Icon(Icons.timer_rounded,
                                        size: 12,
                                        color: submitted
                                            ? Colors.grey
                                            : Colors.red.shade500),
                                    const SizedBox(width: 3),
                                    Text(_timeLabel,
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: submitted
                                                ? Colors.grey
                                                : Colors.red.shade600)),
                                  ]),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(task.title,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: submitted
                                      ? Colors.grey.shade400
                                      : const Color(0xFF1A1A2E),
                                  decoration: submitted
                                      ? TextDecoration.lineThrough
                                      : null)),
                          const SizedBox(height: 3),
                          Row(children: [
                            Icon(Icons.help_outline_rounded,
                                size: 13, color: Colors.grey.shade400),
                            const SizedBox(width: 4),
                            Text('${task.questions?.length ?? 0} questions',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade400)),
                            const SizedBox(width: 10),
                            Icon(Icons.person_outline_rounded,
                                size: 13, color: Colors.grey.shade400),
                            const SizedBox(width: 4),
                            Text(task.teacher,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade400)),
                          ]),
                        ]),
                  ),
                ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
            decoration: BoxDecoration(
              color: deadlineColor.withOpacity(0.06),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: submitted
                ? Row(children: [
              Icon(Icons.check_circle_rounded,
                  size: 16, color: Colors.green.shade500),
              const SizedBox(width: 6),
              Text('Quiz submitted! Great job! 🎉',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.green.shade600)),
            ])
                : Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.schedule_rounded,
                        size: 14, color: deadlineColor),
                    const SizedBox(width: 5),
                    Text(info.label,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: deadlineColor)),
                  ]),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade400,
                          Colors.purple.shade600
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Start Quiz →',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: task.deadlineProgress,
                  minHeight: 6,
                  backgroundColor: deadlineColor.withOpacity(0.15),
                  color: deadlineColor,
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Summary Chip
// ─────────────────────────────────────────────────────────────
class _SummaryChip extends StatelessWidget {
  final String label;
  final Color color;
  final String icon;
  const _SummaryChip(
      {required this.label, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(children: [
        Text(icon, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700, color: color)),
      ]),
    );
  }
}