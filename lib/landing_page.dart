import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/Components/app_button.dart';
import 'package:reconnect/login_page.dart';
import 'package:reconnect/signup_page.dart';

class LandingPage extends StatelessWidget{
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {

    void onTapLogin(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }

    void onTapSignUp(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage(),));
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 280,bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("ReConnect",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox.square(dimension: 35,),
                  Text("Connect, Engage, and\nThrive",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  Text("Your for campus life,alumni\nconnect, and giving back",textAlign: TextAlign.center,),
                  SizedBox.square(dimension: 35,),
                  AppButton(buttonName: "Login",buttonColor: Colors.blue,ontap:  onTapLogin,),
                  SizedBox.square(dimension: 20,),
                  AppButton(buttonName: "Sign Up",buttonColor: Colors.grey.shade300,ontap: onTapSignUp,),
                ],
              ),
              Column(
                children: [
                  Text("2025 ReConnect"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}