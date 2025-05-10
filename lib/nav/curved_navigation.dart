import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class curved_navigation extends StatelessWidget {
  const curved_navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Curver NavigationBar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
          // Icon(CupertinoIcons.heart_fill, color: Colors.white),
          Icon(CupertinoIcons.profile_circled, color: Colors.white),
        ],
      ),
      body: Center(
        child: Text(
          "Body",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
