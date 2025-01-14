// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:khada_book/core/globel_variable.dart';
// import 'package:khada_book/firebaseauth.dart';
// import 'package:khada_book/signup.dart';
// import 'package:khada_book/view/bottom_navbar/bottomnav.dart';

// final auth1 = Authentication();

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String? documentId;
//   bool obsck = true;
//   final _auth = FirebaseAuth.instance;
//   final signmailcontroller = TextEditingController();
//   final signpasswardcontroller = TextEditingController();
//   // getUser({required String email, required String password}){
//   //   FirebaseAuth.instance.signInWithEmailAndPassword(
//   //       email: email, password: password).then((value) =>
//   //       Navigator.push(context, MaterialPageRoute(
//   //           builder: (context) =>HomeScreen())));
//   //   FirebaseFirestore.instance.collection("users")
//   //       .doc("Q2kWPlT4O8UeZZJ5yPPUwXxw3XR2")
//   //       .update({
//   //     "lastLogged":DateTime.now()
//   //   });
//   // }
//   // .doc("1j6fUueCaSfcTJop5YV0KQXQ2Co2")
//   Future<String?> getDocumentId(String email) async {
//     String? docId;
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       docId = querySnapshot.docs[0].id;
//     }

//     return docId;
//   }

//   Future<void> getUser(
//       {required String email, required String password}) async {
//     try {
//       final userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);

//       final userId = userCredential.user!.uid; // Accessing the user ID

//        documentId = await getDocumentId(email);
//       print("${documentId}==============");
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Login Successful')));

//       // Navigate to the HomeScreen
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => BasicBottomNavBar(uid: '$documentId',)),
//       );

//       // Update last logged time in Firestore
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(userId) // Using userId to update the document
//           .update({"lastLogged": DateTime.now()});
//     } catch (e) {
//       // If login fails, show an error message
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Login Failed. Please try again.')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//      SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp, // Allow only portrait orientation
//       // DeviceOrientation.landscapeLeft, // Allow landscape left orientation
//       // DeviceOrientation.landscapeRight, // Allow landscape right orientation
//       // Add more orientations as needed
//     ]);
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             Container(
//               height: h,
//               width: w,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade900,
//                 // image: DecorationImage(
//                 //     image: AssetImage('assets/img/sch1.jpg'),
//                 //     fit: BoxFit.fill)
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(left: w * 0.1, right: h * 0.1),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: h * .01,
//                     ),
//                     Container(
//                       height: h * .8,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Login',
//                             style: GoogleFonts.lexend(
//                                 fontSize: w * .1,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white),
//                           ),
//                           SizedBox(
//                             height: h * .055,
//                           ),
//                           Container(
//                             height: h * .065,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(7),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.only(left: w * .028),
//                               child: TextFormField(
//                                 controller: signmailcontroller,
//                                 style: GoogleFonts.lexend(
//                                     color: const Color(0xff9E9E9E),
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: w * .035),
//                                 keyboardType: TextInputType.emailAddress,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   contentPadding: EdgeInsets.zero,
//                                   hintText: "Email",
//                                   hintStyle: GoogleFonts.lexend(
//                                       color: const Color(0xff9E9E9E),
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: w * .035),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * .0275,
//                           ),
//                           Container(
//                             height: h * .065,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(7),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.only(left: w * .028),
//                               child: TextFormField(
//                                 controller: signpasswardcontroller,
//                                 obscureText: obsck,
//                                 style: GoogleFonts.lexend(
//                                     color: const Color(0xff9E9E9E),
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: w * .035),
//                                 keyboardType: TextInputType.name,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     hintText: "Password",
//                                     hintStyle: GoogleFonts.lexend(
//                                         color: const Color(0xff9E9E9E),
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: w * .035),
//                                     suffixIcon: GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           obsck = !obsck;
//                                         });
//                                       },
//                                       child: obsck
//                                           ? const Icon(Icons.visibility)
//                                           : const Icon(Icons.visibility_off),
//                                     )),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * .0275,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               getUser(
//                                   email: signmailcontroller.text,
//                                   password: signpasswardcontroller.text);
//                             },
//                             child: Container(
//                               height: h * .065,
//                               decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                 child: Text(
//                                   'Continue',
//                                   style: GoogleFonts.lexend(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: w * .055,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               auth1.signup(context);
//                             },
//                             child: Center(
//                               child: Container(
//                                 width: double.infinity,
//                                 height: h * .065,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: Colors.white),
//                                 // child: Image(image: AssetImage("assets/img/google_logo.webp"),
//                                 //   // fit: BoxFit.cover,
//                                 // ),
//                                 child: Image.asset('images/google.png'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const SignUpPage(),
//                                   ));
//                             },
//                             child: Text(
//                               'Sign up using Email',
//                               style: GoogleFonts.lexend(
//                                   fontSize: w * .039,
//                                   decoration: TextDecoration.underline,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: h * .02,
//                         ),
//                         Center(
//                           child: Text(
//                             'By continuing, you agree to our\nTerms of Service Privacy Policy  Content Policy',
//                             style: GoogleFonts.lexend(
//                                 fontSize: w * .025, color: Colors.white),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
