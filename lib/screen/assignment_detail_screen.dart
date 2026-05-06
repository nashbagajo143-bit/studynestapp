import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AssignmentDetailScreen extends StatefulWidget {
  final Tasks task;
  const AssignmentDetailScreen({super.key, required this.task});

  @override
  State<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _photoAttached = false;
  bool _submitted = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final hasText  = _controller.text.trim().isNotEmpty;
    final hasPhoto = _photoAttached;

    bool valid = switch (widget.task.answerType) {
      AnswerType.typeOnly  => hasText,
      AnswerType.photoOnly => hasPhoto,
      AnswerType.both      => hasText && hasPhoto,
    };

    if (!valid) {
      String msg = switch (widget.task.answerType) {
        AnswerType.typeOnly  => 'Please type your answer first! ✏️',
        AnswerType.photoOnly => 'Please attach a photo first! 📸',
        AnswerType.both      => 'Please type your answer AND attach a photo! 📸✏️',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Colors.orange.shade600,
        duration: const Duration(seconds: 2),
      ));
      return;
    }

    setState(() {
      _submitted = true;
      widget.task.status = TaskStatus.sent;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('🎉', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 12),
            const Text('Submitted!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1A1A2E))),
            const SizedBox(height: 6),
            Text(
              'Great job, ${widget.task.teacher} will check your work!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('⭐ +10 Stars Earned!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFFF59E0B))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // back to tasks
                },
                child: const Text('Back to Tasks 📋',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task   = widget.task;
    final info   = task.deadlineInfo;
    final Color deadlineColor = [
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.red.shade600,
    ][info.level];

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
              color: task.color.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_rounded, size: 16, color: Colors.white),
          ),
        ),
        title: Text(
          task.subject,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Header card ──────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: task.color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: task.color, width: 1.5),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: task.color, borderRadius: BorderRadius.circular(14)),
                  child: Icon(task.icon, size: 26, color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(task.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1A1A2E))),
                    Text(task.teacher,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ]),
                ),
              ]),
              const SizedBox(height: 14),
              Text(task.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.5)),
            ]),
          ),

          const SizedBox(height: 16),

          // ── Deadline countdown ────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: deadlineColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: deadlineColor.withOpacity(0.25)),
            ),
            child: Column(children: [
              Row(children: [
                Icon(Icons.alarm_rounded, color: deadlineColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  info.label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: deadlineColor),
                ),
                const Spacer(),
                Text(
                  _formatDate(task.deadline),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ]),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: task.deadlineProgress,
                  minHeight: 8,
                  backgroundColor: deadlineColor.withOpacity(0.15),
                  color: deadlineColor,
                ),
              ),
            ]),
          ),

          const SizedBox(height: 20),

          // ── Answer section ────────────────────────────────────────
          const Text('📝 Your Answer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E))),
          const SizedBox(height: 12),

          // Type answer
          if (task.answerType == AnswerType.typeOnly || task.answerType == AnswerType.both)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: _controller,
                enabled: !_submitted,
                maxLines: 5,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Type your answer here... ✏️',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  contentPadding: const EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),

          if (task.answerType == AnswerType.both) const SizedBox(height: 12),

          // Photo answer
          if (task.answerType == AnswerType.photoOnly || task.answerType == AnswerType.both)
            GestureDetector(
              onTap: _submitted ? null : () => setState(() => _photoAttached = !_photoAttached),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 130,
                decoration: BoxDecoration(
                  color: _photoAttached ? Colors.green.shade50 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _photoAttached ? Colors.green.shade300 : Colors.grey.shade300,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      _photoAttached ? Icons.check_circle_rounded : Icons.camera_alt_rounded,
                      size: 36,
                      color: _photoAttached ? Colors.green.shade500 : Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _photoAttached ? 'Photo Attached! ✅' : 'Tap to Attach Photo 📸',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _photoAttached ? Colors.green.shade600 : Colors.grey.shade500,
                      ),
                    ),
                  ]),
                ),
              ),
            ),

          const SizedBox(height: 24),

          // ── Answer type label ─────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: task.color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('ℹ️', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                switch (task.answerType) {
                  AnswerType.typeOnly  => 'This task requires a typed answer',
                  AnswerType.photoOnly => 'This task requires a photo',
                  AnswerType.both      => 'This task requires both text and a photo',
                },
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ]),
          ),

          const SizedBox(height: 24),

          // ── Submit button ─────────────────────────────────────────
          if (!_submitted)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade400, Colors.teal.shade700],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.4),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: _submit,
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Submit Assignment', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                      SizedBox(width: 8),
                      Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    ]),
                  ),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.check_circle_rounded, color: Colors.green.shade600),
                const SizedBox(width: 8),
                Text('Submitted!',
                    style: TextStyle(color: Colors.green.shade700, fontSize: 16, fontWeight: FontWeight.w800)),
              ]),
            ),
        ]),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}