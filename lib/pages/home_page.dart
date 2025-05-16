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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.themeController,
      builder: (context, _) {
        return Scaffold(
          body: _getPageAtIndex(_selectedIndex),
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
      },
    );
  }

  Widget _getPageAtIndex(int index) {
    switch (index) {
      case 0:
        return _buildMainScreen();
      case 1:
        return NotePage(themeController: widget.themeController);
      case 2:
        return const ProfilePage();
      default:
        return const Center(child: Text("Página no encontrada"));
    }
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
          const Text(
            "Home",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
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
                      if (val) {
                        widget.themeController.enableAutoMode();
                      } else {
                        widget.themeController.disableAutoMode();
                      }
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
                      widget.themeController.toggleTheme();
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
          ),
        ],
      ),
    );
  }
}
