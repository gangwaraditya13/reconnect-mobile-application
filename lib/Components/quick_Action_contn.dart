import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuickActionContn extends StatelessWidget {
  String title;
  String imagePathLocal;

  QuickActionContn(
      {super.key,required this.title, required this.imagePathLocal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 4.0),
          ),
        ],
        color: Colors.white70, // Optional for background color
        borderRadius: BorderRadius.circular(
            8), // Optional for rounded corners
      ),
      child: Column(
        children: [
          Image(image: AssetImage(imagePathLocal), width: 50, height: 50),
          Text(title),
        ],
      ),
    );
  }
}