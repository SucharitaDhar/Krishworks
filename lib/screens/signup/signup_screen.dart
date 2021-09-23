import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishworks/components/account_check.dart';
import 'package:krishworks/components/input_field.dart';
import 'package:krishworks/components/password_field.dart';
import 'package:krishworks/components/rounded_button.dart';
import 'package:krishworks/constants.dart';
import 'package:krishworks/screens/home/home_screen.dart';
import 'package:krishworks/screens/login/login_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String name;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
          padding: EdgeInsets.only(top: 70, left: 20, right: 20),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Text(
                  "SIGNUP",
                  style: kTitleStyle,
                ),
                SizedBox(height: size.height * 0.02),
                Image.asset(
                  "assets/logo.png",
                  height: size.height * 0.30,
                ),
                InputField(
                  hintText: "Your Name",
                  onChanged: (value) {
                    name = value;
                  },
                ),
                InputField(
                  hintText: "Your Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                PasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                ),
                RoundedButton(
                    text: "SIGNUP",
                    press: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        UserCredential result =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        // _auth.currentUser.updateDisplayName(name);
                        User user = result.user;
                        await user.updateDisplayName(name);
                        if (result != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e)));
                      }
                    }),
                SizedBox(height: size.height * 0.03),
                AccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ]))),
    ));
  }
}
