import 'package:flutter/material.dart';
import 'package:reconnect/Components/app_bottom_bar.dart';
import 'package:reconnect/HomePages/chat_page.dart';
import 'package:reconnect/HomePages/explore_page.dart';
import 'package:reconnect/HomePages/profile_page.dart';
import 'package:reconnect/landing_page.dart';

class HomePage extends StatefulWidget {
  String? userName;
  String? alumni;
  String? role = "s";
  HomePage({super.key, this.userName, this.alumni, this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _slectedIndex = 0;

  void navigateButtomBar(int index) {
    setState(() {
      _slectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      //Profile page
      ProfilePage(userName: widget.userName.toString(),institution: widget.alumni,roll: widget.role.toString(),),
      // explore page
      ExplorePage(),
      //chat page
      ChatPage(),
    ];

    void onTapLogout(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage(),));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.userName}"),
        backgroundColor: Colors.white10,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(child: CircleAvatar(
                    foregroundImage: NetworkImage("https://imgs.search.brave.com/y64hDN5z6qUBoUxJVA_UCLoHWNEfjJyvtGsNbKSUfEo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM3/MzMyNzIxNC9waG90/by9iZWF1dGlmdWwt/eW91bmctd29tYW4t/bW9kZWwtcG9zaW5n/LWx5aW5nLWRvd24t/aW4tc3R1ZGlvLW9u/LWNvbG9yZWQtYmFj/a2dyb3VuZC13aXRo/LWNvcHktc3BhY2Uu/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PUg4NHlVNDVRUnpM/bEszRjRvUHA3dlNq/bzhGWWlrOWFwSHBl/S2NhYWo5RmM9"),
                    radius: 65,
                  )),
                  Text(widget.userName.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                ],
              ),
              ListTile(
                onTap: onTapLogout,
                title: Text("Logout",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                trailing: Icon(Icons.logout),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: AppBottomBar(
        onTabChange: (index) => navigateButtomBar(index),
      ),
      body: _pages[_slectedIndex],
    );
  }
}
