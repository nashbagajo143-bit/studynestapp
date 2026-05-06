import 'package:flutter/material.dart';
import 'package:mystudynestflutter/dashboard_elementary.dart';
import 'package:mystudynestflutter/GradeSelection_page.dart';
import 'package:mystudynestflutter/profile/account_settings_page.dart';
import 'package:mystudynestflutter/profile/notifications_page.dart';
import 'package:mystudynestflutter/profile/help_support_page.dart';
import 'package:mystudynestflutter/screen/tasks_screen.dart';
import 'package:mystudynestflutter/widgets/achievements_page.dart';



class AuthState {
  static bool isLoggedIn = true;
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardElementary(),
        ),
      );
    }

    else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TasksScreen(),
        ),
      );
    }

    else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  AchievementsScreen(),
        ),
      );
    }

    else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    }
  }


  void _goToGradeSelection() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => GradeSelectionScreen()),
          (route) => false, // clears entire stack — no back button back in
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // tap outside = cancel, no black screen
      builder: (dialogContext) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log Out',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          // CANCEL — only closes the dialog, nothing else happens
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),

          // LOG OUT — update state → close dialog → navigate
          ElevatedButton(
            onPressed: () {
              // 1. Mark as logged out
              AuthState.isLoggedIn = false;

              // 2. Close dialog using its own context (prevents black screen)
              Navigator.of(dialogContext).pop();

              // 3. Navigate only after dialog is fully dismissed
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _goToGradeSelection();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FB),
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
                fontWeight: FontWeight.bold, fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_turned_in_rounded), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events_rounded),
                  label: 'Achievements'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded), label: 'Profile'),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Manage your account',
                    style: TextStyle(fontSize: 14, color: Colors.black45),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Profile Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF24304A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF24304A), width: 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xFF7986CB),
                                  Color(0xFF5B6AF5),
                                ]),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: const Center(
                                child: Text(
                                  'AJ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Elne Labawan',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text('Grade 5',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF9FA8DA))),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1, color: Colors.white24),
                        const SizedBox(height: 14),
                        Row(
                          children: const [
                            Icon(Icons.mail_outline,
                                size: 16, color: Color(0xFF9FA8DA)),
                            SizedBox(width: 10),
                            Text('elne.labawan@email.com',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF9FA8DA))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(Icons.calendar_today_outlined,
                                size: 16, color: Color(0xFF9FA8DA)),
                            SizedBox(width: 10),
                            Text('Joined May 2026',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF9FA8DA))),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      _StatCard(value: '47', label: 'Completed'),
                      SizedBox(width: 12),
                      _StatCard(value: '12', label: 'In Progress'),
                      SizedBox(width: 12),
                      _StatCard(value: '92%', label: 'Avg Score'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _MenuItem(
                          icon: Icons.settings_outlined,
                          label: 'Account Settings',
                          iconColor: const Color(0xFF5B6AF5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AccountSettingsPage()),
                          ),
                        ),
                        const Divider(height: 1, indent: 56),
                        _MenuItem(
                          icon: Icons.notifications_outlined,
                          label: 'Notifications',
                          iconColor: const Color(0xFF5B6AF5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NotificationsPage()),
                          ),
                        ),
                        const Divider(height: 1, indent: 56),
                        _MenuItem(
                          icon: Icons.help_outline_rounded,
                          label: 'Help & Support',
                          iconColor: const Color(0xFF5B6AF5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HelpSupportPage()),
                          ),
                        ),
                        const Divider(height: 1, indent: 56),
                        _MenuItem(
                          icon: Icons.logout_rounded,
                          label: 'Log Out',
                          iconColor: Colors.redAccent,
                          labelColor: Colors.redAccent,
                          onTap: () => _confirmLogout(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'StudyNest v1.0.0 · Grade 3-6 Portal',
                      style: TextStyle(fontSize: 11, color: Colors.white38),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF24304A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: Color(0xFF9FA8DA))),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color? labelColor;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: labelColor ?? const Color(0xFF1A1A2E),
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: labelColor ?? Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}