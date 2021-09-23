import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishworks/components/input_field.dart';
import 'package:krishworks/components/rounded_button.dart';
import 'package:krishworks/constants.dart';
import 'package:krishworks/screens/login/login_screen.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 70, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "RESET PASSWORD",
              style: kTitleStyle,
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            InputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedButton(
              text: "SUBMIT",
              press: () async {
                await _auth.sendPasswordResetEmail(email: email);
                showAlert(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}

showAlert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text(
                'A password reset link has been sent to your registered email-ID'),
            actions: <Widget>[
              TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  })
            ]);
      });
}
