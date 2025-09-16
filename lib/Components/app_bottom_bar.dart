import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomBar extends StatelessWidget {
  void Function(int)? onTabChange;
  AppBottomBar({super.key, this.onTabChange});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
        child: GNav(
          tabBackgroundColor: Colors.white,
          activeColor: Colors.blue[300],
          gap: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          tabBorderRadius: 16,
          onTabChange: (index) => onTabChange!(index),
          tabs: [
            GButton(icon: Icons.person,text: "Profile",),
            GButton(icon: Icons.explore,text: "Explore",),
            GButton(icon: Icons.chat,text: "Chat",),
          ],
        ),
      ),
    );
  }
}
