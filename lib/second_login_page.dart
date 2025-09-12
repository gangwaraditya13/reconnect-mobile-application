import 'package:flutter/material.dart';
import 'package:reconnect/home_page.dart';

import 'Components/User_Detail_Input.dart';
import 'Components/app_button.dart';

class SecondLoginPage extends StatelessWidget {
  const SecondLoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController usernameController = TextEditingController();
    TextEditingController gmailController = TextEditingController();
    TextEditingController OTPController = TextEditingController();
    
    void onTapSecondNext(){
      String usernameControllerString = usernameController.text.toString();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(userName: usernameControllerString,),));
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text("Create Account",style: TextStyle(fontWeight: FontWeight.bold),),
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0,left: 15.0),
        child: Form(
          child: Column(
              children: [
                SizedBox.square(dimension: 15,),
                UserDetailInput(nameController: usernameController,hint: "UserName",),
                SizedBox.square(dimension: 15,),
                UserDetailInput(nameController: gmailController,hint: "Gmail address",),
                SizedBox.square(dimension: 15,),
            TextFormField(
              controller: OTPController,
              validator: (value) {
                //validate
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: (){}, icon: Text("Resend OTP")),
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
                SizedBox.square(dimension: 15,),
                AppButton(buttonName: "Next ✔️", buttonColor: Colors.blue, ontap: onTapSecondNext),
              ]
          ),
        ),
      ),
    );
  }
}
