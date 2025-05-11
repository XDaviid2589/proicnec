import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:proicnec/pages/note_page.dart';
import 'package:proicnec/pages/profile_page.dart';
import 'package:proicnec/utils/theme_controller.dart';
import 'package:proicnec/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  final ThemeController themeController;
  const HomePage({required this.themeController, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();

  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildMainScreen(),
      NotePage(themeController: widget.themeController),
      const ProfilePage(),
    ]);
  }

  void _logout() async {
    await authService.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  Widget _buildMainScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text("Home", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("Auto Modo"),
                  Switch(
                    value: widget.themeController.autoModeEnabled,
                    onChanged: (val) {
                      setState(() {
                        val
                            ? widget.themeController.enableAutoMode()
                            : widget.themeController.disableAutoMode();
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Tema Oscuro"),
                  Switch(
                    value: widget.themeController.themeMode == ThemeMode.dark,
                    onChanged: (_) {
                      setState(() {
                        widget.themeController.toggleTheme();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text("Cerrar sesión"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        color: Colors.blue,
        backgroundColor: Colors.transparent,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.note, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}
