import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:zoom/var.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool _isdata = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
   // DocumentSnapshot userdoc = await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: GradientColors.facebookMessenger)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 2 - 64,
                top: MediaQuery.of(context).size.height / 3.1),
            child: CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/proxy/Y1d9FAsUbHliPC0JUXDw06Fahrx6Y46kpQ6OTMkMgEhGNIrPDQV4uNgQD0fskMFihhVR69kc9gglDgor_EDuKZyZBn44Ed06e5hpqH_9UXA6e_MpCWnf1_Js-lVzoD99NUniCBiah7cNaA'),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                ),
                Text(
                  'Arslan',
                  textAlign: TextAlign.center,
                  style: myStyle(40, Colors.black),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: GradientColors.cherry),
                  ),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: myStyle(17, Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
