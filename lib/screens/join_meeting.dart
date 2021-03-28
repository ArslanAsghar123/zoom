import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom/var.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  String code = '';
  createCode(){
    setState(() {
        code = Uuid().v1().substring(0,6);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Create a code to invite friends to the meenting',
              style: myStyle(20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Code: ',
                style: myStyle(30),
              ),
              Text(
                code,
                style: myStyle(30, Colors.purple, FontWeight.w700),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => createCode(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: GradientColors.facebookMessenger),
              ),
              child: Center(
                child: Text(
                  'Create Code',
                  style: myStyle(20,Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
