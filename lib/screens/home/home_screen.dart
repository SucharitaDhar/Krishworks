import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishworks/components/rounded_button.dart';
import 'package:krishworks/constants.dart';
import 'package:krishworks/screens/welcome/welcome_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String name;

  void getName() async {
    // User user = _auth.currentUser;
    name = _auth.currentUser.displayName;
  }

  @override
  Widget build(BuildContext context) {
    getName();
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 200, left: 70, right: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Hello $name !', style: kTitleStyle),
                SizedBox(height: 300),
                RoundedButton(
                  text: 'SIGN OUT',
                  press: () {
                    _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WelcomeScreen();
                        },
                      ),
                    );
                  },
                )
              ],
            )));
  }
}
