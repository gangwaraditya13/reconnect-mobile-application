import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetailInput extends StatelessWidget {
  final TextEditingController nameController;
  final String? hint;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final bool obscureText;
  final Widget? PrefixIcon;
  final FormFieldValidator<String>? Validator;
  final TextInputType? keyboardType;  // Added property here

  UserDetailInput({
    super.key,
    required this.nameController,
    this.hint,
    this.enabledBorderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.obscureText = false,
    this.PrefixIcon,
    this.Validator,
    this.keyboardType,  // Accept keyboardType here
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      obscureText: obscureText,
      validator: Validator,
      keyboardType: keyboardType,  // Pass keyboardType here
      decoration: InputDecoration(
        prefixIcon: PrefixIcon,
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}