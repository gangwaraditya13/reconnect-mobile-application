import 'package:flutter/material.dart';
import 'package:reconnect/home_page.dart';
import 'package:reconnect/Components/User_Detail_Input.dart';
import 'package:reconnect/Components/app_button.dart';
import 'package:reconnect/repos/user_repo.dart';

class SecondLoginPage extends StatefulWidget {
  const SecondLoginPage({super.key});

  @override
  State<SecondLoginPage> createState() => _SecondLoginPageState();
}

class _SecondLoginPageState extends State<SecondLoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController OTPController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ApiService apiService = ApiService(baseUrl: 'http://10.0.2.2:3000/api');

  void onTapSecondNext() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final emailText = gmailController.text.trim();
    final otpText = OTPController.text.trim();

    bool verified = await apiService.verifyOtp(emailText, otpText);

    if (verified) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(userName: usernameController.text.trim())));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid OTP, please try again.")));
    }
  }

  void onTapSendOTP() {
    final emailText = gmailController.text.trim();
    if (emailText.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill Gmail")));
      return;
    }

    // Implement resend OTP API call if available, else notify
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("OTP sent to your email.")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              "Create Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 15),
              UserDetailInput(
                nameController: usernameController,
                hint: "UserName",
                Validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Username is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              UserDetailInput(
                nameController: gmailController,
                hint: "Gmail address",
                Validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Gmail is required";
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: OTPController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "OTP is required";
                  }
                  if (value.trim().length != 6) {
                    return "OTP should be 6 digits";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: onTapSendOTP, icon: Text("Resend OTP")),
                  labelText: "OTP",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              AppButton(buttonName: "Next ✔️", buttonColor: Colors.blue, ontap: onTapSecondNext),
            ],
          ),
        ),
      ),
    );
  }
}