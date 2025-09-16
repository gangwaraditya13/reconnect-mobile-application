import 'package:flutter/material.dart';
import 'package:reconnect/Components/User_Detail_Input.dart';
import 'package:reconnect/Components/app_button.dart';
import 'package:reconnect/login_page.dart';
import 'package:reconnect/repos/user_repo.dart';
import 'package:reconnect/second_login_page.dart';

enum UserType { alumni, student }

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  UserType? _selectedUserType;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ApiService apiService = ApiService(baseUrl: 'http://10.0.2.2:3000/api');

  void onTapNext() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select Alumni or Student")));
      return;
    }

    Map<String, dynamic> userData = {
      'username': '${firstName.text.trim()}${lastName.text.trim()}',
      'email': email.text.trim(),
      'password': password.text.trim(),
      'fullName': {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
      },
      'role': _selectedUserType == UserType.alumni ? 'alumni' : 'student',
      'phone': phone.text.trim(),
    };

    bool registered = await apiService.registerUser(userData);

    if (registered) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SecondLoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed. Please try again.")));
    }
  }

  void onPressLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 15),
              UserDetailInput(
                nameController: firstName,
                hint: "First name",
                Validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "First name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              UserDetailInput(
                nameController: lastName,
                hint: "Last name",
                Validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Last name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              UserDetailInput(
                nameController: email,
                hint: "Email address",
                Validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              UserDetailInput(
                nameController: phone,
                hint: "Phone number",
                Validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Phone number is required";
                  }
                  if (value.trim().length != 10 || !RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                    return "Enter a valid 10-digit phone number";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 15),
              UserDetailInput(
                nameController: password,
                hint: "Password",
                obscureText: true,
                Validator: (value) {
                  if (value == null || value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              UserDetailInput(
                nameController: rePassword,
                hint: "Reenter Password",
                obscureText: true,
                Validator: (value) {
                  if (value == null || value != password.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Radio buttons for Alumni/Student
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
              SizedBox(height: 15),

              AppButton(buttonName: "Next ->", buttonColor: Colors.blue, ontap: onTapNext),

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
