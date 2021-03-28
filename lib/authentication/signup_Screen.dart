import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:zoom/authentication/login_screen.dart';
import 'package:zoom/helper/save_login_info.dart';
import 'package:zoom/var.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool _isLoading = false;

  Future<void> SignUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //  user.sendEmailverification();
        HelperClass.saveUserLoggedInDetails(isLoggedin: true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogIn()));
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print(e.message("Exaption"));
      }
      // ignore: unnecessary_statements
      //context.read<AuthenticationService>().signIn;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: GradientColors.blue),
                  ),
                  child: Center(
                    child: Image.asset(
                      'images/logo.png',
                      height: 100,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.6,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 3)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Form(
                      key: _formKey,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: TextFormField(
                              validator: (val) {
                                return val.isEmpty ? "Enter Name" : null;
                              },
                              style: myStyle(20, Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintText: "Email",
                              ),
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: TextFormField(

                              validator: (val) {
                                return val.isEmpty ? "Enter Password" : null;
                              },
                              obscureText: true,
                              style: myStyle(20, Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.enhanced_encryption),
                                hintText: "Password",
                              ),
                              onChanged: (val) {
                                password = val;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () => SignUp(),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: GradientColors.pink,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "SIGN UP",
                                  style: myStyle(20, Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
