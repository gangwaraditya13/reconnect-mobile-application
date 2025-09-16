import 'package:flutter/material.dart';
import 'package:reconnect/Components/User_Detail_Input.dart';
import 'package:reconnect/Components/app_button.dart';
import 'package:reconnect/home_page.dart';
import 'package:reconnect/signup_page.dart';
import 'package:reconnect/repos/user_repo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ApiService apiService = ApiService(baseUrl: 'http://10.0.2.2:3000/api');

  bool isLoading = false;

  void onTapSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  void onTapLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool success = await apiService.loginUser(
      emailAddress.text.trim(),
      password.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userName: emailAddress.text.trim(),
            // Pass other parameters if needed
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed. Check your credentials.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 270, bottom: 10),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "ConnectU",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text("Welcome back! Please enter your details."),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        UserDetailInput(
                          nameController: emailAddress,
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
                        SizedBox(height: 10),
                        UserDetailInput(
                          nameController: password,
                          hint: "Password",
                          obscureText: true,
                          Validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : AppButton(
                  buttonName: "Login",
                  buttonColor: Colors.blue,
                  ontap: onTapLogin,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: onTapSignUp,
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "By Continuing, you agree to our"),
                    TextSpan(
                      text: " Terms of Service",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " and"),
                    TextSpan(
                      text: "\nPrivacy Policy.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}