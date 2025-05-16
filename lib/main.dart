import 'package:flutter/material.dart';
import 'package:proicnec/auth/auth_gate.dart';
import 'package:proicnec/nav/curved_navigation.dart';
import 'package:proicnec/pages/home_page.dart';
import 'package:proicnec/pages/login_page.dart';
import 'package:proicnec/pages/note_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:proicnec/utils/theme_controller.dart';

final themeController = ThemeController(); // instancia global

void main() async {
  //supabase setup
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhaWF3YmpyZ2d5dWhva2Zsd2N5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY3Mjk3NzcsImV4cCI6MjA2MjMwNTc3N30.0FGIWjIYr0AHYisvlITv1xlzOpH6tw5ncssMT8oFoAA",
    url: "https://daiawbjrggyuhokflwcy.supabase.co",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        themeController.checkAutoUpdate(); // ✅ MUÉVELO AQUÍ

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.themeMode,
          initialRoute: "/login",
          routes: {
            "/login": (_) => const LoginPage(),
            "/home": (_) => HomePage(themeController: themeController),
          },
        );
      },
    );
  }
}
