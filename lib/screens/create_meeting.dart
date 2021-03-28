import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zoom/var.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  bool isVideoMuted = true;
  bool isAudioMuted = true;
String username = '';

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    DocumentSnapshot userdoc = await firestoreInstance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['usermane'];
    });
  }

  joinmeeting() async {
    try{

      var stopwatch = Stopwatch();
        FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;

      Map<FeatureFlagEnum, bool> featureFlags =
      {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false,
        FeatureFlagEnum.ADD_PEOPLE_ENABLED : true,
        FeatureFlagEnum.CALENDAR_ENABLED :false,
        FeatureFlagEnum.INVITE_ENABLED : false,
        FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
        FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE : false,
        FeatureFlagEnum.PIP_ENABLED : true,
      };


      if(Platform.isAndroid){
       // featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
        featureFlag.callIntegrationEnabled = false;

      }else if (Platform.isIOS){
        // featureFlag[FeatureFlagEnum.PIP_ENABLED] = false;
        featureFlag.pipEnabled = false;

      }
      var option = JitsiMeetingOptions()
        ..room = roomController.text
        ..userDisplayName = nameController.text == ''? username: nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted  = isVideoMuted
        ..featureFlag = featureFlag;


      await JitsiMeet.joinMeeting(option,listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {

        debugPrint("${option.room} will join with message: $message");
      }, onConferenceJoined: ({message}) {
        stopwatch.start();
        debugPrint("${option.room} joined with message: $message");
      }, onConferenceTerminated: ({message})async{
        stopwatch.stop();
        debugPrint("${option.room} terminated with message: $message,time = ${stopwatch.elapsed.abs().inSeconds}");
      }),);
     }catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                'Room Code',
                style: myStyle(20),
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                controller: roomController,
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                animationDuration: Duration(milliseconds: 300),
                appContext: context,
                length: 6,
                onChanged: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: nameController,
                style: myStyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name (if you want your username)",
                  labelStyle: myStyle(15),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value;
                  });
                },
                title: Text(
                  'Video Muted',
                  style: myStyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  'Audio Muted',
                  style: myStyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "of course, you can customize your setiings in video",
                style: myStyle(15),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joinmeeting(),
                child: Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger),
                  ),
                  child: Center(
                    child: Text(
                      'join Meeting',
                      style: myStyle(20, Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
