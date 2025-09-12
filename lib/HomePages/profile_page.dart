import 'package:flutter/material.dart';
import 'package:reconnect/Components/quick_Action_contn.dart';
import 'package:reconnect/HomePages/events_pages.dart';
import 'package:reconnect/edit_user.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mentorship_page.dart';

class ProfilePage extends StatelessWidget {
  String? userName;
  String? institution;
  String? bioUser;
  String? experience;
  String? currentPosition;
  String? currentCompany;
  String? batchOfUser;
  String? courseOfUser;
  String? skillsOfUser;
  String? linkedInUrl;
  String roll;

  ProfilePage(
      {super.key,
      this.userName,
      this.institution,
      this.skillsOfUser,
      this.batchOfUser,
      this.bioUser,
      this.courseOfUser,
      this.linkedInUrl,
      required this.roll});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    void onPressEdit() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditUser(roll: roll,bioUser: bioUser,batchOfUser: batchOfUser,courseOfUser: courseOfUser,currentCompany: currentCompany,currentPosition: currentPosition,institution: institution,linkedInUrl: linkedInUrl,skillsOfUser: skillsOfUser,),
          ));
    }

    void onPressEvent() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsPage(),
          ));
    }

    void onPressMentorship() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MentorshipPage(),
          ));
    }

    if(roll.toLowerCase() == "student"){
    return
      Padding(
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
                        "https://imgs.search.brave.com/y64hDN5z6qUBoUxJVA_UCLoHWNEfjJyvtGsNbKSUfEo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM3/MzMyNzIxNC9waG90/by9iZWF1dGlmdWwt/eW91bmctd29tYW4t/bW9kZWwtcG9zaW5n/LWx5aW5nLWRvd24t/aW4tc3R1ZGlvLW9u/LWNvbG9yZWQtYmFj/a2dyb3VuZC13aXRo/LWNvcHktc3BhY2Uu/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PUg4NHlVNDVRUnpM/bEszRjRvUHA3dlNq/bzhGWWlrOWFwSHBl/S2NhYWo5RmM9"),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userName.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(institution.toString()),
                      ],
                    ),
                  ),
                  IconButton(onPressed: onPressEdit, icon: Icon(Icons.edit))
                ],
              ),
            ),
            SizedBox.square(
              dimension: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("course: "),
                      Text(courseOfUser.toString()),
                      Text(", " + batchOfUser.toString()),
                    ],
                  ),
                  Text("Skills: "),
                  Text(skillsOfUser.toString()),
                  Text("bio: "),
                  Text(bioUser.toString()+"\nExperience: "+experience.toString()+"\nCurrent Company:"+currentCompany.toString()+"\nCurrent Position: "+currentPosition.toString()),
                  Row(
                    children: [
                      Text("Linkedin: "),
                      SocialMediaButton.linkedin(
                        size: 20,
                        color: Colors.blue,
                        onTap: () => _launchUrl(linkedInUrl.toString()),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quick Actions"),
                  SizedBox.square(
                    dimension: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: onPressEvent,
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
    );}else{
      return  Padding(
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
                          "https://imgs.search.brave.com/y64hDN5z6qUBoUxJVA_UCLoHWNEfjJyvtGsNbKSUfEo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM3/MzMyNzIxNC9waG90/by9iZWF1dGlmdWwt/eW91bmctd29tYW4t/bW9kZWwtcG9zaW5n/LWx5aW5nLWRvd24t/aW4tc3R1ZGlvLW9u/LWNvbG9yZWQtYmFj/a2dyb3VuZC13aXRo/LWNvcHktc3BhY2Uu/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PUg4NHlVNDVRUnpM/bEszRjRvUHA3dlNq/bzhGWWlrOWFwSHBl/S2NhYWo5RmM9"),
                      radius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            userName.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(institution.toString()),
                        ],
                      ),
                    ),
                    IconButton(onPressed: onPressEdit, icon: Icon(Icons.edit))
                  ],
                ),
              ),
              SizedBox.square(
                dimension: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("course: "),
                        Text(courseOfUser.toString()),
                        Text(", " + batchOfUser.toString()),
                      ],
                    ),
                    Text("Skills: "),
                    Text(skillsOfUser.toString()),
                    Text("bio: "),
                    Text(bioUser.toString()+"\nExperience: "+experience.toString()+"\nCurrent Company:"+currentCompany.toString()+"\nCurrent Position: "+currentPosition.toString()),
                    Row(
                      children: [
                        Text("Linkedin: "),
                        SocialMediaButton.linkedin(
                          size: 20,
                          color: Colors.blue,
                          onTap: () => _launchUrl(linkedInUrl.toString()),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quick Actions"),
                    SizedBox.square(
                      dimension: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: onPressMentorship,
                            icon: QuickActionContn(
                              title: "Mentorship",
                              imagePathLocal: "lib/Assets/mentoreship_logo.png",
                            )),
                        SizedBox.square(
                          dimension: 10,
                        ),
                        IconButton(
                            onPressed: onPressEvent,
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
}
