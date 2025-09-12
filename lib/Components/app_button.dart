import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String buttonName;
  Color buttonColor;
  VoidCallback ontap;
  AppButton({super.key, required this.buttonName, required this.buttonColor, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width/1.08,
        height: 55,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(child: Text(buttonName)),
      ),
    );
  }
}
