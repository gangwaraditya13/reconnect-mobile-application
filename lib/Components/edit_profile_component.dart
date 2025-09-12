import 'package:flutter/material.dart';

class EditProfileComponent extends StatelessWidget {
  var nameController;
  String? hint;
  Color enabledBorderColor;
  Color focusedBorderColor;
  Color setColor;
  int maxline;
  Widget? SuffixIcon;
  EditProfileComponent(
      {super.key,
      required this.nameController,
      this.hint,
      this.enabledBorderColor = Colors.grey,
      this.focusedBorderColor = Colors.blue,
      this.maxline = 1,
      this.SuffixIcon,
      this.setColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      style: TextStyle(color: setColor),
      maxLines: maxline,
      decoration: InputDecoration(
          suffixIcon: SuffixIcon,
          labelText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
