import 'package:flutter/material.dart';
import 'package:reconnect/other_user_profile_page.dart';

class UserListtile extends StatelessWidget {

  String userName;
  String bioOfUser;
  String? url;
  String? GmailId;

  UserListtile({super.key, required this.userName, required this.bioOfUser, this.url, required this.GmailId});

  @override
  Widget build(BuildContext context) {
    String profilePic;
    if(url == null || url!.trim().toLowerCase() == 'null' || url!.isEmpty){
      profilePic = "https://imgs.search.brave.com/LfnkmUWTA3s256VIPk7pU1ST5WPNyU965AP0BO-6H7s/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS12ZWN0/b3IvZGVmYXVsdC1h/dmF0YXItcHJvZmls/ZS1pY29uLXNvY2lh/bC1tZWRpYS11c2Vy/LWltYWdlLWdyYXkt/YXZhdGFyLWljb24t/YmxhbmstcHJvZmls/ZS1zaWxob3VldHRl/LXZlY3Rvci1pbGx1/c3RyYXRpb25fNTYx/MTU4LTMzOTYuanBn/P3NlbXQ9YWlzX2h5/YnJpZCZ3PTc0MCZx/PTgw";
    }else{
      profilePic = url.toString();
    }
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtherUserProfilePage(GmailId: GmailId.toString()),));
      },
      leading: CircleAvatar(
        radius: 40,
        foregroundImage: NetworkImage(profilePic),
      ),
      title: Text(userName),
      subtitle: Text(bioOfUser),
    );
  }
}
