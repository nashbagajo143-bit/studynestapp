

//TRASH

import 'package:flutter/material.dart';
import 'package:mystudynestflutter/dashboard_kinder.dart'; // ✅ Direct import
import 'package:mystudynestflutter/screen/tasks_screen.dart';
import 'package:mystudynestflutter/nav/profile_page1.dart';


class LearningGamesPage extends StatefulWidget {
  const LearningGamesPage({super.key});

  @override
  State<LearningGamesPage> createState() => _LearningGamesPageState();
}

class _LearningGamesPageState extends State<LearningGamesPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 2; // ✅ Edugames highlighted
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ✅ PERFECT NAVIGATION - Connects to ALL screens
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardKinder(),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TasksScreen(),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LearningGamesPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen1(),
        ),
      );
    }
  }

  // Sample games data (unchanged)
  final List<Map<String, dynamic>> games = [
    {
      'title': 'Math Mania',
      'description': 'Practice addition, subtraction & more!',
      'icon': Icons.calculate_rounded,
      'color': Color(0xFF3B82F6),
      'highScore': 1250,
      'bestTime': '2:15',
      'image': 'https://api.dicebear.com/7.x/bottts/png?seed=mathgame&backgroundColor=bfdbfe',
      'level': 7,
    },
    {
      'title': 'Word Wizard',
      'description': 'Build words & boost vocabulary!',
      'icon': Icons.auto_stories_rounded,
      'color': Color(0xFF10B981),
      'highScore': 89,
      'bestTime': '1:42',
      'image': 'https://api.dicebear.com/7.x/bottts/png?seed=wordgame&backgroundColor=a7f3d0',
      'level': 5,
    },
    {
      'title': 'Planet Quest',
      'description': 'Explore space & learn astronomy!',
      'icon': Icons.public_rounded,
      'color': Color(0xFF8B5CF6),
      'highScore': 342,
      'bestTime': '3:28',
      'image': 'https://api.dicebear.com/7.x/bottts/png?seed=spacegame&backgroundColor=e9d5ff',
      'level': 4,
    },
    {
      'title': 'Shape Match',
      'description': 'Identify shapes & patterns!',
      'icon': Icons.shape_line_rounded,
      'color': Color(0xFFF59E0B),
      'highScore': 210,
      'bestTime': '1:58',
      'image': 'https://api.dicebear.com/7.x/bottts/png?seed=shapegame&backgroundColor=fcd34d',
      'level': 6,
    },
    {
      'title': 'Number Dash',
      'description': 'Count fast & race to win!',
      'icon': Icons.speed_rounded,
      'color': Color(0xFFEF4444),
      'highScore': 1890,
      'bestTime': '0:56',
      'image': 'https://api.dicebear.com/7.x/bottts/png?seed=numbergame&backgroundColor=fecaca',
      'level': 9,
    },
  ];

  void _launchGame(BuildContext context, Map<String, dynamic> game) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Launching ${game['title']}... 🎮'),
        backgroundColor: game['color'],
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Play Now',
          textColor: Colors.white,
          onPressed: () => _showGameDemo(context, game),
        ),
      ),
    );
  }

  void _showGameDemo(BuildContext context, Map<String, dynamic> game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(game['icon'], color: game['color'], size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                game['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(game['description']),
            const SizedBox(height: 16),
            Text(
              'High Score: ${game['highScore']}\nBest Time: ${game['bestTime']}\nLevel: ${game['level']}',
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: game['color'],
              foregroundColor: Colors.white,
            ),
            child: const Text('Play Game'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () {
            // ✅ DIRECTLY GOES TO DASHBOARD KINDER
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardKinder(),
              ),
            );
          },
        ),
        title: const Text(
          'EduGames',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF1A1A2E),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.star_rounded),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
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
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped, // ✅ CONNECTED NAVIGATION
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
                label: 'Edugames', // ✅ HIGHLIGHTED
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Daily Challenge Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily Challenge',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Complete 3 games to earn 50 coins!',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.rocket_launch_rounded, size: 20),
                      label: const Text(
                        'Play Challenge',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Games Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];
                  return AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: _GameCard(
                          game: game,
                          onTap: () => _launchGame(context, game),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _GameCard (unchanged)
class _GameCard extends StatelessWidget {
  final Map<String, dynamic> game;
  final VoidCallback onTap;

  const _GameCard({
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 8,
      shadowColor: game['color'].withOpacity(0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        game['image'],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [game['color'], game['color'].withOpacity(0.7)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            game['icon'],
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Lv ${game['level']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                game['title'],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                game['description'],
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${game['highScore']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: game['color'],
                          ),
                        ),
                        const Text(
                          'High Score',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          game['bestTime'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: game['color'],
                          ),
                        ),
                        const Text(
                          'Best Time',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}