import 'package:flutter/material.dart';
import 'package:reconnect/Components/quick_Action_contn.dart';
import 'package:reconnect/HomePages/events_pages.dart';
import 'package:reconnect/HomePages/mentorship_page.dart';
import 'package:reconnect/edit_user.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherUserProfilePage extends StatelessWidget {
  String GmailId;
  String? userName;

  OtherUserProfilePage({super.key, this.userName, required this.GmailId});

  @override
  Widget build(BuildContext context) {
    String? bioUser;
    String? batchOfUser;
    String? courseOfUser;
    String? skillsOfUser;
    String? linkedInUrl;
    String? experience;
    String? currentPosition;
    String? currentCompany;

    Future<void> _launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    void onPressMentorship() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MentorshipPage(),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Alumni"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://imgs.search.brave.com/y64hDN5z6qUBoUxJVA_UCLoHWNEfjJyvtGsNbKSUfEo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM3/MzMyNzIxNC9waG90/by9iZWF1dGlmdWwt/eW91bmctd29tYW4t/bW9kZWwtcG9zaW5n/LWx5aW5nLWRvd24t/aW4tc3R1ZGlvLW9u/LWNvbG9yZWQtYmFj/a2dyb3VuZC13aXRo/LWNvcHktc3BhY2Uu/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PUg4NHlVNDVRUnpM/bEszRjRvUHA3dlNq/bzhGWWlrOWFwSHBl/S2NhYWo5RmM9"),
                radius: 50,
              ),
              Text(
                userName.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
