import 'package:flutter/material.dart';
import 'package:zoom/screens/profile.dart';
import 'package:zoom/screens/video_conference.dart';
import 'package:zoom/var.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int page = 0;
List pageoptions = [
  VideoConferenceScreen(),
  ProfileScreen()
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: myStyle(17, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: myStyle(17, Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Video Call'),
            icon: Icon(
              Icons.video_call,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ],
      ),
      body: pageoptions[page],
    );
  }
}
