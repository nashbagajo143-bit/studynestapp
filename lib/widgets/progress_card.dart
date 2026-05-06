import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int sent;
  final int total;

  const ProgressCard({super.key, required this.sent, required this.total});

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : sent / total;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E0FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const Text('📚', style: TextStyle(fontSize: 22)),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
              children: [
                const TextSpan(text: 'You sent '),
                TextSpan(
                  text: '$sent of $total',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9060DD),
                  ),
                ),
                const TextSpan(text: ' assignments'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFAA55EE)),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Keep it up! 🎉',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}