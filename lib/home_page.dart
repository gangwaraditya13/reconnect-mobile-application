import 'package:flutter/material.dart';
import 'package:reconnect/Components/app_bottom_bar.dart';
import 'package:reconnect/HomePages/chat_page.dart';
import 'package:reconnect/HomePages/explore_page.dart';
import 'package:reconnect/HomePages/profile_page.dart';
import 'package:reconnect/landing_page.dart';

class HomePage extends StatefulWidget {
  final String? userName;
  final String? alumni;
  final String? role;

  HomePage({super.key, this.userName, this.alumni, this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onTapLogout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      ProfilePage(
        userName: widget.userName.toString(),
        institution: widget.alumni,
        roll: widget.role.toString(),
      ),
      ExplorePage(),
      ChatPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.userName}"),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                          "https://imgs.search.brave.com/y64hDN5z6qUBoUxJVA_UCLoHWNEfjJyvtGsNbKSUfEo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRpYS5nZXR0eWltYWdlcy5jb20vaWQvMTM3MzMyNzIxNC9waG90by9iZWF1dGlmdWwt"),
                      radius: 65,
                    ),
                  ),
                  Text(
                    widget.userName.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              ListTile(
                onTap: onTapLogout,
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar:
      AppBottomBar(onTabChange: (index) => navigateBottomBar(index)),
      body: _pages[_selectedIndex],
    );
  }
}