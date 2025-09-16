import 'package:flutter/material.dart';
import 'package:reconnect/repos/user_repo.dart';
import '../Components/edit_profile_component.dart';
import 'Components/Exprence.dart';

class EditUser extends StatefulWidget {
  final String? userName;
  final String? institution;
  final String? courseOfUser;
  final String? batchOfUser;
  final String? skillsOfUser;
  final String? bioUser;
  final String? currentPosition;
  final String? currentCompany;
  final String? linkedInUrl;
  final String roll;
  final List<Map<String, dynamic>>? experience;
  // Add other fields if necessary

  EditUser({
    super.key,
    this.userName,
    this.institution,
    this.courseOfUser,
    this.batchOfUser,
    this.skillsOfUser,
    this.bioUser,
    this.currentPosition,
    this.currentCompany,
    this.linkedInUrl,
    required this.roll,
    this.experience,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController nameController, institutionController, courseController,
      batchController, skillsController, bioController, companyController, positionController, linkedInController;

  List<Map<String, dynamic>> experienceList = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userName ?? '');
    institutionController = TextEditingController(text: widget.institution ?? '');
    courseController = TextEditingController(text: widget.courseOfUser ?? '');
    batchController = TextEditingController(text: widget.batchOfUser ?? '');
    skillsController = TextEditingController(text: widget.skillsOfUser ?? '');
    bioController = TextEditingController(text: widget.bioUser ?? '');
    companyController = TextEditingController(text: widget.currentCompany ?? '');
    positionController = TextEditingController(text: widget.currentPosition ?? '');
    linkedInController = TextEditingController(text: widget.linkedInUrl ?? '');
    experienceList = widget.experience != null ? List<Map<String, dynamic>>.from(widget.experience!) : [];
  }

  Future<void> _editExperience() async {
    final updated = await Navigator.push<List<Map<String, dynamic>>>(
      context,
      MaterialPageRoute(
        builder: (context) => ExperienceAdditionPage(initialExperience: experienceList),
      ),
    );
    if (updated != null) {
      setState(() {
        experienceList = updated;
      });
    }
  }

  void _onSave() {
    // You'd send this structured map to your backend.
    Map<String, dynamic> updated = {
      "userName": nameController.text.trim(),
      "institution": institutionController.text.trim(),
      "course": courseController.text.trim(),
      "batch": batchController.text.trim(),
      "skills": skillsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      "bio": bioController.text.trim(),
      "currentCompany": companyController.text.trim(),
      "currentPosition": positionController.text.trim(),
      "linkedIn": linkedInController.text.trim(),
      "experience": experienceList,
      "roll": widget.roll,
    };
    Navigator.pop(context, updated);
  }

  @override
  void dispose() {
    nameController.dispose();
    institutionController.dispose();
    courseController.dispose();
    batchController.dispose();
    skillsController.dispose();
    bioController.dispose();
    companyController.dispose();
    positionController.dispose();
    linkedInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [IconButton(onPressed: _onSave, icon: Icon(Icons.save))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            EditProfileComponent(nameController: nameController, hint: 'Name'),
            EditProfileComponent(nameController: institutionController, hint: 'Institution'),
            EditProfileComponent(nameController: courseController, hint: 'Course'),
            EditProfileComponent(nameController: batchController, hint: 'Batch (e.g., June 2020)'),
            EditProfileComponent(nameController: skillsController, hint: 'Skills (comma separated)'),
            EditProfileComponent(nameController: bioController, hint: 'Bio'),
            if (widget.roll.toLowerCase() != "student") ...[
              EditProfileComponent(nameController: companyController, hint: 'Current Company'),
              EditProfileComponent(nameController: positionController, hint: 'Current Position'),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: Text("Edit Experience"),
                onPressed: _editExperience,
              ),
            ],
            EditProfileComponent(nameController: linkedInController, hint: 'LinkedIn URL'),
          ],
        ),
      ),
    );
  }
}