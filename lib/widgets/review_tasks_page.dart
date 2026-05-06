import 'package:flutter/material.dart';

class PastTasksPage extends StatelessWidget {
  final List<Map<String, dynamic>> completedTasks;

  const PastTasksPage({
    super.key,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0FF),
      appBar: AppBar(
        title: Text('Review Tasks (${completedTasks.length})'),
        backgroundColor: Colors.blue,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
      ),
      body: completedTasks.isEmpty
          ? _emptyState(context) // ✅ FIXED
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: completedTasks.length,
        itemBuilder: (context, index) =>
            _completedTaskCard(context, completedTasks[index]), // ✅ FIXED
      ),
    );
  }

  // ✅ FIXED: added BuildContext
  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF40C9C0).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.task_alt_rounded,
                size: 60, color: Color(0xFF40C9C0)),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Completed Tasks',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E)),
          ),
          const SizedBox(height: 8),
          const Text(
            'Submit tasks to review your scores here',
            style: TextStyle(fontSize: 16, color: Color(0xFF666677)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to Tasks'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF40C9C0),
              padding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ FIXED: added BuildContext
  Widget _completedTaskCard(
      BuildContext context, Map<String, dynamic> task) {

    // ✅ FIXED: null-safe score
    final score = task['score'] ?? 0;
    final scoreColor = score >= 90
        ? const Color(0xFF40C9C0)
        : const Color(0xFFFFB8D0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: task['color'],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showReview(context, task),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(task['icon'],
                          size: 24, color: const Color(0xFF333355)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['title'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A2E)),
                          ),
                          Text(
                            'Reviewed • ${task['date']}',
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF444466)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Teacher Review',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('•',
                        style: TextStyle(color: Color(0xFF888899))),
                    const SizedBox(width: 8),
                    Text(
                      task['duration'],
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF444466)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task['subject'],
                      style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF444466),
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: scoreColor, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            '$score',
                            style: TextStyle(
                                color: scoreColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text('%',
                              style: TextStyle(
                                  color: scoreColor, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReview(
      BuildContext context, Map<String, dynamic> assignment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: assignment['color'].withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child:
              Icon(assignment['icon'], color: assignment['color']),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(assignment['title'])),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Score: ${assignment['score']}%'),
            const SizedBox(height: 12),
            Text('Teacher Feedback: ${assignment['feedback']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}