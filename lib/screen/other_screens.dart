import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0FF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_book_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text('Library', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text('Coming soon!', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
            ],
          ),
        ),
      ),
    );
  }
}

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0FF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events_outlined, size: 64, color: Colors.amber[300]),
              const SizedBox(height: 16),
              Text('Achievements', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text('Keep completing assignments to earn badges! 🏅', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0FF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: const Color(0xFFD8C8F0),
                child: const Icon(Icons.person, size: 44, color: Color(0xFF9060DD)),
              ),
              const SizedBox(height: 16),
              const Text('My Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
              const SizedBox(height: 8),
              Text('Student', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
            ],
          ),
        ),
      ),
    );
  }
}