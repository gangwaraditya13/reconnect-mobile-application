import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/Components/User_Detail_Input.dart';
import 'package:reconnect/Components/user_listtile.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    
    TextEditingController userSearchController = TextEditingController();
    List users = [1,2,3,4,5,6,7,8,9,10];
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            UserDetailInput(nameController: userSearchController,hint: "Search",PrefixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.search),)),
            Container(
              height: 650,
                width: double.maxFinite,
                child: ListView.builder(itemBuilder: (context, index) => Column(
                  children: [
                    UserListtile(userName: "lora", bioOfUser: "software dev",url: "https://imgs.search.brave.com/fHZcSJ0khy0_T7lJeTcvEo6IefpPllSkpmAqCSRZYuY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTE3/NjEzMDY1L3Bob3Rv/L2h1bWFuLWJyYWlu/LmpwZz9zPTYxMng2/MTImdz0wJms9MjAm/Yz1FTGFxVjZheDNW/N2N4S284eFBqdGsx/OFN5dTdRZnRmemg5/aWlqanZFSHNFPQ",GmailId: "${users[index]}",),
                    Container(
                      color: Colors.white12,
                      width: double.maxFinite,
                      height: 4,
                    )
                  ],
                ),itemCount: users.length,)),
          ],
        ),
      ),
    );
  }
}
