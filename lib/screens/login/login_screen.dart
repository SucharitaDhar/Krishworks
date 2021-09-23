import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishworks/components/account_check.dart';
import 'package:krishworks/components/input_field.dart';
import 'package:krishworks/components/password_field.dart';
import 'package:krishworks/components/rounded_button.dart';
import 'package:krishworks/constants.dart';
import 'package:krishworks/screens/forgot_password/forgot_password.dart';
import 'package:krishworks/screens/home/home_screen.dart';
import 'package:krishworks/screens/signup/signup_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
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
                "LOGIN",
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
              PasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
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
                },
              ),
              SizedBox(height: size.height * 0.03),
              AccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgotPasswordScreen();
                        },
                      ),
                    );
                  },
                  child: Text('Forgot Password ?',
                      style: TextStyle(color: kPrimaryLightColor)))
            ],
          ),
        ),
      ),
    ));
  }
}
