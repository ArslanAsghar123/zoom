import 'package:flutter/material.dart';
import 'package:zoom/screens/create_meeting.dart';
import 'package:zoom/screens/join_meeting.dart';
import 'package:zoom/var.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  buildtab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: myStyle(15, Colors.black, FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Zoom',
            style: myStyle(20, Colors.white, FontWeight.bold),
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildtab("Create Meeting"),
            buildtab("Join Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [JoinMeeting(), CreateMeeting()],
      ),
    );
  }
}
