import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensenote/loginpagee.dart';
import 'package:expensenote/view/bottom_navbar/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<void> loginUser(BuildContext context, String email, String password) async {
  //   try {
  //     final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     // Save user login state using shared preferences
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setBool('isLoggedIn', true);
  //     prefs.setString('userUid', userCredential.user!.uid);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(backgroundColor: Colors.white,content: Text('login successful!',style: TextStyle(color: Colors.black),)),
  //     );
  //     // Navigate to home screen on successful login
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => BasicBottomNavBar()),
  //     );
  //   } catch (e) {
  //     // Handle login failure
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Login Failed. Please try again.')),
  //     );
  //   }
  // }
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      // Show attractive loading indicator while waiting for authentication and data retrieval
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.blue.shade900, // Choose your desired color
              size: 50.0, // Adjust the size of the spinner
            ),
          );
        },
      );
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user login state using shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

      // Retrieve additional user data from Firestore using a query
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email',
              isEqualTo:
                  email) // Assuming 'email' is a field in your user documents
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Get the document ID of the first document in the result
        String documentId = userSnapshot.docs[0].id;
        prefs.setString('userUid', documentId); // Save document ID
        // Dismiss loading indicator
        Navigator.of(context, rootNavigator: true).pop();
        print('${documentId}===]]');
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Login successful!',
                style: TextStyle(color: Colors.white)),
          ),
        );

        // Navigate to home screen on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BasicBottomNavBar(uid: documentId)),
        );
      }
    } catch (e) {
      // Dismiss loading indicator
      Navigator.of(context, rootNavigator: true).pop();
      String errorMessage = 'Login Failed. Please try again.';

      // Handle specific error cases
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else if (e.code == 'invalid-email') {
          errorMessage =
              'Invalid email format. Please check your email address.';
        } else if (e.code == 'network-request-failed') {
          errorMessage =
              'Network error. Please check your internet connection.';
        }
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content:
              Text(errorMessage, style: const TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Save user login state using shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('userUid', 'tdNdksdev7eTR87MuNla');

      // Navigate to home screen on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BasicBottomNavBar(
                  uid: 'tdNdksdev7eTR87MuNla',
                )),
      );
    } catch (e) {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Google Sign-In Failed. Please try again.')),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    // Clear user session from shared preferences on sign out
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.remove('userUid');

    // Navigate to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
