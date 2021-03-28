import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom/helper/save_login_info.dart';
import 'package:zoom/screens/homepage.dart';
import 'package:zoom/screens/intro_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: NavigationPage(),
    );
  }
}
class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
bool _isLoading = false;
  bool _isLoggedin = false;
  @override
  void initState() {
    checkUserLoggedInstatus();
    super.initState();
    // Add code after super
  }

  checkUserLoggedInstatus() async{
    HelperClass.getUserLoggedInDetails().then((value){
      setState(() {
        _isLoggedin = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : (_isLoggedin ?? false) ? Homepage():IntroAuthScreen(),
    );
  }
}


