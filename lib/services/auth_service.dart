// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
//         (User user) => user?.uid,
//       );

//   //Email and Password Sign Up
//   Future<String> createUser(String email, String password, String name) async {
//     final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//         return currentUser.uid;
//   }

//   //Update the username
//   await _firebaseAuth.currentUser.updateProfile(displayName:user.displayName);
// }

// //Email and Password Sign in
// Future<String> signIn(String email, String Password) async {
// return (await _firebaseAuth.signInwithEmailAndPassword(email, Password)).uid;
// }