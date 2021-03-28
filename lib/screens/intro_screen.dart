import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:zoom/authentication/auth_screen.dart';
import 'package:zoom/var.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: 'Welcome',
            body: 'Welcome to Zoom, the best video chatting App',
            image: Center(
              child: Image.asset(
                'images/welcome.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: myStyle(20, Colors.black),
              titleTextStyle: myStyle(20, Colors.black),
            )),
        PageViewModel(
            title: 'Join And Start meetings',
            body: 'Now you can join with friends',
            image: Center(
              child: Image.asset(
                'images/conference.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: myStyle(20, Colors.black),
              titleTextStyle: myStyle(20, Colors.black),
            )),
        PageViewModel(
            title: 'Privacy and policy',
            body: 'Don\'t Worry we got your back',
            image: Center(
              child: Image.asset(
                'images/secure.jpg',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: myStyle(20, Colors.black),
              titleTextStyle: myStyle(20, Colors.black),
            )),
      ],
      onDone: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)  => NavigationAuthScreen()));
      },
      onSkip: () {},
      showSkipButton: true,
      skip: Icon(Icons.skip_next,size: 45,),
      next: Icon(Icons.arrow_forward_ios),
      done: Text(
        'Done',style: myStyle(20,Colors.black),
      ),
    );
  }
}
