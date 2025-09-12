import 'package:flutter/material.dart';
import 'package:reconnect/Components/User_Detail_Input.dart';
import 'package:reconnect/Components/app_button.dart';
import 'package:reconnect/login_page.dart';
import 'package:reconnect/second_login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

enum UserType { alumni, student }

class _SignupPageState extends State<SignupPage> {
  UserType? _selectedUserType; // store radio selection

  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = TextEditingController();
    TextEditingController lastName = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController rePassword = TextEditingController();

    void onTapNext() {
      if (_selectedUserType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select Alumni or Student")),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondLoginPage()),
      );
    }

    void onPressLogin() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Form(
              child: Column(
                children: [
                  SizedBox.square(dimension: 15),
                  UserDetailInput(nameController: firstName, hint: "First name"),
                  SizedBox.square(dimension: 15),
                  UserDetailInput(nameController: lastName, hint: "Last name"),
                  SizedBox.square(dimension: 15),
                  UserDetailInput(nameController: email, hint: "Email address"),
                  SizedBox.square(dimension: 15),
                  UserDetailInput(nameController: password, hint: "Password"),
                  SizedBox.square(dimension: 15),
                  UserDetailInput(
                      nameController: rePassword, hint: "Reenter Password"),
                  SizedBox.square(dimension: 15),
                ],
              ),
            ),
            // Radio buttons for Alumni/Student
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<UserType>(
                      value: UserType.alumni,
                      groupValue: _selectedUserType,
                      onChanged: (value) {
                        setState(() {
                          _selectedUserType = value;
                        });
                      },
                    ),
                    Text("Alumni"),
                    SizedBox(width: 20),
                    Radio<UserType>(
                      value: UserType.student,
                      groupValue: _selectedUserType,
                      onChanged: (value) {
                        setState(() {
                          _selectedUserType = value;
                        });
                      },
                    ),
                    Text("Student"),
                  ],
                ),
                SizedBox.square(dimension: 15),
                AppButton(
                  buttonName: "Next ->",
                  buttonColor: Colors.blue,
                  ontap: onTapNext,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    TextButton(
                      onPressed: onPressLogin,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}