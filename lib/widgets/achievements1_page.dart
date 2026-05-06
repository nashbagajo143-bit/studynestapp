import 'package:flutter/material.dart';
import 'package:mystudynestflutter/dashboard_kinder.dart';


class AchievementsScreen1 extends StatefulWidget {
  const AchievementsScreen1({super.key});

  @override
  State<AchievementsScreen1> createState() => _AchievementsScreen1State();
}

class _AchievementsScreen1State extends State<AchievementsScreen1> {
  int _selectedIndex = 2; // Achievements is index 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: Colors.blue,
        foregroundColor: const Color(0xFF1E2A44),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardKinder(),
              ),
            );
          },
        ),
      ),

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
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events, size: 100, color: Colors.amber),
            SizedBox(height: 20),
            Text(
              "Achievements",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Your achievements will appear here!",
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}