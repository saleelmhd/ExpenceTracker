import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensenote/loginpagee.dart';
import 'package:expensenote/model/accountusermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/globel_variable.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool obsc = true;
  bool obsc1 = true;
  final _auth = FirebaseAuth.instance;
  final usernamecontroller = TextEditingController();
  final signmailcontroller = TextEditingController();
  final signpasswardcontroller = TextEditingController();
  final signconfirmpassword = TextEditingController();
  final signphonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Allow only portrait orientation
      // DeviceOrientation.landscapeLeft, // Allow landscape left orientation
      // DeviceOrientation.landscapeRight, // Allow landscape right orientation
      // Add more orientations as needed
    ]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h,
              color: Colors.blue.shade900,
              child:  Padding(
                padding:  EdgeInsets.only(left: w * .078, right: w * .078),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: h * .1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: w * .042,
                              child:  Center(
                                  child: Icon(
                                    Icons.arrow_circle_left_rounded,
                                    color: Colors.blue.shade900,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: w * .03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: h * .007),
                            child: Text(
                              'Back',
                              style: GoogleFonts.lexend(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: h * .82,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello there!\nLet’s get introduced.',
                            style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w500,
                                fontSize: w * .06,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: h * .034375,
                          ),
                          Text(
                            'What’s your name?',
                            style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w500,
                                fontSize: w * .034,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: h * .006875,
                          ),
                          Container(
                            height: h * .07,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * .028),
                              child: TextFormField(
                                controller: usernamecontroller,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffBBC5CD),
                                    fontSize: w * .039),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Full name",
                                  hintStyle: GoogleFonts.poppins(
                                      color: const Color(0xffBBC5CD),
                                      fontSize: w * .039),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * .032,
                          ),
                          Text(
                            'What’s your email?',
                            style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w500,
                                fontSize: w * .034,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: h * .006875,
                          ),
                          Container(
                            // height: h*.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * .028),
                              child: TextFormField(
                                controller: signmailcontroller,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffBBC5CD),
                                    fontSize: w * .039),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.poppins(
                                      color: const Color(0xffBBC5CD),
                                      fontSize: w * .039),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * .020,
                          ),
                          // Text(
                          //   'Your age and birth date',
                          //   style: GoogleFonts.lexend(
                          //       fontWeight: FontWeight.w500,
                          //       fontSize: w * .034,
                          //       color: Colors.white),
                          // ),
                          // SizedBox(
                          //   height: h * .006875,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       height: h * .06,
                          //       width: w * .2,
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(13),
                          //       ),
                          //       child: Padding(
                          //         padding: EdgeInsets.only(left: w * .028),
                          //         child: TextFormField(
                          //           maxLines: 1,
                          //           //maxLength: 2,
                          //           autovalidateMode: AutovalidateMode.onUserInteraction,
                          //           style: GoogleFonts.poppins(
                          //             color: Color(0xffBBC5CD),
                          //             fontSize: w * .039,
                          //           ),
                          //           keyboardType: TextInputType.number,
                          //           // validator: (value) {
                          //           //   if (value == null) {
                          //           //     return 'Please enter your age.';
                          //           //   }
                          //           //   final ageValue = int.tryParse(value)??15;
                          //           //   if (ageValue < 15 || ageValue > 99) {
                          //           //     return 'Please enter a valid age between 15 and 99.';
                          //           //   }
                          //           //   return null; // Return null if the input is valid
                          //           // },
                          //           decoration: InputDecoration(
                          //             border: InputBorder.none,
                          //             focusedBorder: InputBorder.none,
                          //             hintText: "Age",
                          //             hintStyle: GoogleFonts.poppins(
                          //               color: Color(0xffBBC5CD),
                          //               fontSize: w * .039,
                          //             ),
                          //
                          //           ),
                          //         ),
                          //
                          //       ),
                          //     ),
                          //     InkWell(
                          //       onTap: ()  {},
                          //       child: Container(
                          //         height: h * .06,
                          //         width: w * .55,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(13),
                          //         ),
                          //         child: Row(
                          //           children: [
                          //
                          //             Container(
                          //               width: w * .47,
                          //               child: Padding(
                          //                 padding:
                          //                 EdgeInsets.only(left: w * .028),
                          //                 child: Text(
                          //                   'Date | Month | Year',
                          //                   style: GoogleFonts.lexend(
                          //                       fontWeight: FontWeight.w500,
                          //                       fontSize: w * .034,
                          //                       color: Color(0xffBBC5CD)),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: h * .034375,
                          // ),
                          Text(
                            'Phone Number',
                            style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w500,
                                fontSize: w * .034,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: h * .006875,
                          ),
                          Container(
                            height: h * .06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * .028),
                              child: TextFormField(
                                controller: signphonecontroller,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffBBC5CD),
                                    fontSize: w * .039),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Phone number",
                                  hintStyle: GoogleFonts.poppins(
                                      color: const Color(0xffBBC5CD),
                                      fontSize: w * .039),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * .0205,
                          ),
                          Container(
                            height: h * .06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * .028),
                              child: TextFormField(
                                controller: signpasswardcontroller,
                                obscureText: obsc,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffBBC5CD),
                                    fontSize: w * .039),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.poppins(
                                        color: const Color(0xffBBC5CD),
                                        fontSize: w * .039),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon:  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          obsc = ! obsc;
                                        });
                                      },
                                      child: obsc?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * .0205,
                          ),
                          Container(
                            height: h * .06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * .028),
                              child: TextFormField(
                                 obscureText: obsc1,
                                controller: signconfirmpassword,
                               
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffBBC5CD),
                                    fontSize: w * .039),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    suffixIcon:  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          obsc1 = ! obsc1;
                                        });
                                      },
                                      child: obsc?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                                    ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle: GoogleFonts.poppins(
                                      color: const Color(0xffBBC5CD),
                                      fontSize: w * .039),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: h * .075,
                      child: Center(
                        child: InkWell(
                          // onTap: (){
                          //   var model= UsersModel(userEmail:signmailcontroller.text,
                          //     userName: usernamecontroller.text,
                          //     userPhoneNumber: signphonecontroller.text,
                          //     userPassword: signpasswardcontroller.text,
                          //     createDate: DateTime.now(), imageUrl: '', lastLogged:DateTime.now(),
                          //     uid: '',
                          //   );
                          //   _auth
                          //       .createUserWithEmailAndPassword(
                          //     email: signmailcontroller.text,
                          //     password: signpasswardcontroller.text,
                          //   )
                          //       .then((value) {
                          //     FirebaseFirestore.instance
                          //         .collection("users").add(model.toJson()).then((value) =>
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>  LoginPage())),);
                          //
                          //   });
                          //
                          // },
                          onTap: () {
                            // Get user input values
                            String email = signmailcontroller.text.trim();
                            String password = signpasswardcontroller.text.trim();
                            String username = usernamecontroller.text.trim();
                            String phoneNumber = signphonecontroller.text.trim();

                            // Validate user input (you may want to add more validation)
                            if (email.isEmpty || password.isEmpty || username.isEmpty || phoneNumber.isEmpty) {
                              // Show error message or handle invalid input
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill in all fields.')),
                              );
                              return;
                            }

                            // Create user account with email and password
                            _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            ).then((userCredential) {
                              // User registered successfully, now store additional user data in Firestore
                              var userModel = UsersModel(
                                userEmail: email,
                                userName: username,
                                userPhoneNumber: phoneNumber,
                                userPassword: password,
                                createDate: DateTime.now(),
                                imageUrl: '',
                                lastLogged: DateTime.now(),
                                uid: userCredential.user!.uid, // Assign the Firebase UID to the userModel
                              );

                              // Save user data to Firestore
                              FirebaseFirestore.instance.collection('users').add(userModel.toJson()).then((value) {
                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(backgroundColor: Colors.white,content: Text('Sign up successful!',style: TextStyle(color: Colors.black),)),
                                );
                                // Navigate to login page after successful registration
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              }).catchError((error) {
                                // Handle Firestore save error
                                print('Failed to add user data: $error');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('$error.')),
                                );
                              });
                            }).catchError((error) {
                              // Handle registration error
                              print('Failed to register user: $error');
                              String errorMessage = 'Password should be at least 6 characters.';

                              if (error is FirebaseAuthException) {
                                if (error.code == 'email-already-in-use') {
                                  errorMessage = 'The email address is already in use by another account.';
                                }
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)),
                              );
                            });
                          },
                          child: Container(
                            height: h * .06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: const Color(0xff343434)),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}