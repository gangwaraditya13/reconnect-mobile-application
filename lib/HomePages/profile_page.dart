import 'package:flutter/material.dart';
import 'package:reconnect/Components/quick_Action_contn.dart';
import 'package:reconnect/HomePages/events_pages.dart';
import 'package:reconnect/edit_user.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/Exprence.dart';
import 'mentorship_page.dart';

class ProfilePage extends StatefulWidget {
  String? userName;
  String? institution;
  String? bioUser;
  List<Map<String, dynamic>>? experience;
  String? currentPosition;
  String? currentCompany;
  String? batchOfUser;
  String? courseOfUser;
  String? skillsOfUser;
  String? linkedInUrl;
  String roll;

  ProfilePage({
    super.key,
    this.userName,
    this.institution,
    this.skillsOfUser,
    this.batchOfUser,
    this.bioUser,
    this.courseOfUser,
    this.linkedInUrl,
    required this.roll,
    this.experience,
    this.currentPosition,
    this.currentCompany,
  });

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> experienceList = [];

  @override
  void initState() {
    super.initState();
    experienceList = widget.experience ?? [];
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

  void onPressEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUser(
            userName: widget.userName,
            institution: widget.institution,
            courseOfUser: widget.courseOfUser,
            batchOfUser: widget.batchOfUser,
            skillsOfUser: widget.skillsOfUser,
            bioUser: widget.bioUser,
            currentPosition: widget.currentPosition,
            currentCompany: widget.currentCompany,
            linkedInUrl: widget.linkedInUrl,
            roll: widget.roll,
            experience: experienceList),
      ),
    );
    if (result != null && result is Map && result.containsKey('experience')) {
      setState(() {
        experienceList = List<Map<String, dynamic>>.from(result['experience']);
      });
    }
  }

  Future _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(
                        "https://imgs.search.brave.com/y64hDN5z6qUBoUxJVA_UCLoHWNEfjJyvtGsNbKSUfEo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM3/MzMyNzIxNC9waG90/by9iZWF1dGlmdWwt"),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.institution.toString()),
                      ],
                    ),
                  ),
                  IconButton(onPressed: onPressEdit, icon: Icon(Icons.edit)),
                ],
              ),
            ),
            SizedBox.square(dimension: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("course: "),
                      Text(widget.courseOfUser.toString()),
                      Text(", " + widget.batchOfUser.toString()),
                    ],
                  ),
                  Text("Skills: "),
                  Text(widget.skillsOfUser.toString()),
                  Text("bio: "),
                  if (experienceList.isNotEmpty) ...[
                    for (var exp in experienceList)
                      Text(
                          "${exp['title']} at ${exp['company']} (${exp['duration']['start']['month']} ${exp['duration']['start']['year']} - ${exp['duration']['end']['month']} ${exp['duration']['end']['year']})"),
                  ] else ...[
                    Text(widget.bioUser.toString() +
                        "\n" +
                        "\n" +
                        (widget.currentCompany ?? "") +
                        "\nurrent Position: " +
                        (widget.currentPosition ?? "")),
                  ],
                  Row(
                    children: [
                      Text("Linkedin: "),
                      SocialMediaButton.linkedin(
                        size: 20,
                        color: Colors.blue,
                        onTap: () => _launchUrl(widget.linkedInUrl.toString()),
                      ),
                    ],
                  ),
                  if (widget.roll.toLowerCase() != "student") ...[
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text("Edit Experience"),
                      onPressed: _editExperience,
                    ),
                  ]
                ],
              ),
            ),
            // DO NOT MODIFY below this line!
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quick Actions"),
                  SizedBox.square(dimension: 10),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MentorshipPage()),
                            );
                          },
                          icon: QuickActionContn(
                            title: "Mentorship",
                            imagePathLocal: "lib/Assets/mentoreship_logo.png",
                          )),
                      SizedBox.square(dimension: 10),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventsPage()),
                            );
                          },
                          icon: QuickActionContn(
                            title: "Events",
                            imagePathLocal: "lib/Assets/event_logo.png",
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}