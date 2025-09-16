import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/Components/User_Detail_Input.dart';
import 'package:reconnect/Components/user_listtile.dart';

import '../repos/user_repo.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController userSearchController = TextEditingController();

  List users = [];
  bool isLoading = true;

  final ApiService apiService = ApiService(baseUrl: 'http://10.0.2.2:3000/api');

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    setState(() {
      isLoading = true;
    });
    var fetchedUsers = await apiService.getAllUsers();
    if (fetchedUsers != null) {
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } else {
      setState(() {
        users = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            UserDetailInput(
              nameController: userSearchController,
              hint: "Search",
              PrefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return UserListtile(
                    userName: user['username'] ?? 'No Name',
                    bioOfUser: user['bio'] ?? '',
                    url: user['pictureUrl'],
                    GmailId: user['email'] ?? '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}