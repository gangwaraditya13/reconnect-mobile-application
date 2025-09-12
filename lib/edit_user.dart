import 'package:flutter/material.dart';
import 'package:reconnect/Components/app_button.dart';
import 'package:reconnect/Components/edit_profile_component.dart';

class EditUser extends StatefulWidget {
  String? institution;
  String? bioUser;
  String? currentPosition;
  String? currentCompany;
  String? batchOfUser;
  String? courseOfUser;
  String? skillsOfUser;
  String? linkedInUrl;
  String roll;
  EditUser({super.key, this.bioUser,this.currentPosition,this.currentCompany,this.linkedInUrl,this.courseOfUser,this.batchOfUser,this.skillsOfUser,this.institution,required this.roll});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {

    TextEditingController institutionController = TextEditingController(text: widget.institution);
    TextEditingController courseOfUserController = TextEditingController(text: widget.courseOfUser);
    TextEditingController bioUserController = TextEditingController(text: widget.bioUser);
    TextEditingController skillsOfUserController = TextEditingController(text: widget.skillsOfUser);
    TextEditingController currentPositionController = TextEditingController(text: widget.currentPosition);
    TextEditingController currentCompanyController = TextEditingController(text: widget.currentCompany);
    TextEditingController linkedInUrlController = TextEditingController(text: widget.linkedInUrl);

    void ontapAddExperience(){}

    void onPressSave(){
      Navigator.pop(context);
    }

    if(widget.roll!.toLowerCase().toString() == "student"){
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              EditProfileComponent(nameController: institutionController, SuffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month)),hint: "Institution and Batch",),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Batch: ",textAlign: TextAlign.start),
              ),
              EditProfileComponent(nameController: courseOfUserController, hint: "Course",),
              SizedBox.square(dimension: 10,),
              EditProfileComponent(nameController: bioUserController,hint: "Bio",maxline: 3,),
              SizedBox.square(dimension: 10,),
              EditProfileComponent(nameController: skillsOfUserController,hint: "Skills",),
              SizedBox.square(dimension: 10,),
              EditProfileComponent(nameController: linkedInUrlController,hint: "Linkedin Url",),
              SizedBox.square(dimension: 10,),
              IconButton(onPressed: onPressSave, icon: Icon(Icons.save))
            ],
          ),
        ),
      );
    }else{
      return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            EditProfileComponent(nameController: institutionController, SuffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month)),hint: "Institution and Batch",),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Batch: ",textAlign: TextAlign.start,),
            ),
            EditProfileComponent(nameController: courseOfUserController,hint: "Course",),
            SizedBox.square(dimension: 10,),
            EditProfileComponent(nameController: bioUserController,hint: "Bio",),
            SizedBox.square(dimension: 10,),
            EditProfileComponent(nameController: skillsOfUserController,hint: "Skills",),
            SizedBox.square(dimension: 10,),
            EditProfileComponent(nameController: currentCompanyController, hint: "Current Company",),
            SizedBox.square(dimension: 10,),
            EditProfileComponent(nameController: currentPositionController, hint: "Current Position",),
            SizedBox.square(dimension: 10,),
            EditProfileComponent(nameController: linkedInUrlController, hint: "LinkedIn Url",),
            SizedBox.square(dimension: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(buttonName: "Add Experience", buttonColor: Colors.blue.shade400, ontap: ontapAddExperience),
            ),
            SizedBox.square(dimension: 10,),
            IconButton(onPressed: onPressSave, icon: Icon(Icons.save))
          ],
        ),
      ),
    );}
  }
}
