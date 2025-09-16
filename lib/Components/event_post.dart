import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventPost extends StatelessWidget {
  String? date;
  String? status;
  String? title;
  String? description;
  String? location;
  EventPost({super.key, this.title,this.date,this.description, this.location,this.status});

  @override
  Widget build(BuildContext context) {

    void onPressBooked(){

    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              offset: Offset(0, 4), // optional: moves shadow downwards
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("date: ${date!.substring(0,10)}", style: TextStyle(color: Colors.blue),),
                Text(status.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                child: Text(title.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                child: Text(description.toString()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                child: Text("locaton :\n"+location.toString()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: onPressBooked, icon: Icon(Icons.bookmark_add_outlined))
                ],
              ),
              Container(width: double.maxFinite,height: 2,color: Colors.blue.shade100,)
            ],
          ),
        ),
      ),
    );
  }
}
