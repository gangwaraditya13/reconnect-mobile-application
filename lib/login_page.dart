import 'package:flutter/material.dart';
import 'package:reconnect/Components/User_Detail_Input.dart';
import 'package:reconnect/Components/app_button.dart';
import 'package:reconnect/home_page.dart';
import 'package:reconnect/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailAddress = TextEditingController();
    TextEditingController password = TextEditingController();

    void onTapSignUp(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage(),));
    }

    void onTapLogin(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 270, bottom: 10),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Column(
              children: [
                Text("ConnectU",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

            Text("Welcome back! Please enter your details."),
            SizedBox.square(dimension: 35,),
            Padding(
              padding: const EdgeInsets.only(right: 15.0,left: 15.0),
              child: Form(child: Column(
                children: [
                  //email input
                  UserDetailInput(nameController: emailAddress,hint: "Email address",),
            SizedBox.square(dimension: 10,),
                  //password input
                  UserDetailInput(nameController: password, hint: "Password",),
                ],
              )),
            ),
            SizedBox.square(dimension: 20,),
            AppButton(buttonName: "Login", buttonColor: Colors.blue, ontap: onTapLogin),
            SizedBox.square(dimension: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(onPressed: onTapSignUp, child: Text("Sign up",style: TextStyle(color: Colors.blue),))
              ],
            ),
              ],
            ),
            Center(
              child: RichText(textAlign: TextAlign.center,
                  text: TextSpan(
                style: TextStyle(color: Colors.black),
                children:<TextSpan>[
                  TextSpan(text: "By Continuing, you agree to our"),
                  TextSpan(text: " Terms of Service", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " and"),
                  TextSpan(text: "\nPrivacy Policy.", style: TextStyle(fontWeight: FontWeight.bold))
                ]
              )),
            )
          ],
        ),
      ),
    );
  }
}
