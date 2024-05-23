import 'package:expensenote/firebaseauth.dart';
import 'package:expensenote/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/globel_variable.dart';

final auth1=Authentication();
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   String? documentId;
  bool obsck = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Authentication _auth = Authentication();

  void _loginUser() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    _auth.loginUser(context, email, password);
  }

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
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     SizedBox(height: 100),
        //     Text(
        //       'Login to SherCash',
        //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.all(20),
        //       child: Column(
        //         children: [
        //           TextField(
        //             controller: _emailController,
        //             decoration: InputDecoration(labelText: 'Email'),
        //           ),
        //           SizedBox(height: 20),
        //           TextField(
        //             controller: _passwordController,
        //             obscureText: true,
        //             decoration: InputDecoration(labelText: 'Password'),
        //           ),
        //           SizedBox(height: 20),
        //           ElevatedButton(
        //             onPressed: _loginUser,
        //             child: Text('Login'),
        //           ),
        //           SizedBox(height: 20),
        //           TextButton(
        //             onPressed: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(builder: (context) => SignUpPage()),
        //               );
        //             },
        //             child: Text('Sign up using Email'),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        child: Column(
          children: [
            Container(
              height: h,
              width: w,
              decoration:  BoxDecoration(
                color: Colors.blue.shade900,
                // image: DecorationImage(
                //     image: AssetImage('assets/img/sch1.jpg'),
                //     fit: BoxFit.fill)
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: w * 0.1, right: h * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * .01,
                    ),
                    Container(
                      height: h * .8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: GoogleFonts.lexend(
                                fontSize: w * .1,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: h * .055,
                          ),
                          Container(
                            height: h * .065,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * .028),
                              child: TextFormField(
                                controller: _emailController,
                                style: GoogleFonts.lexend(
                                    color: Color(0xff9E9E9E),
                                    fontWeight: FontWeight.w500,
                                    fontSize: w * .035),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.lexend(
                                      color: Color(0xff9E9E9E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: w * .035),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * .0275,
                          ),
                          Container(
                            height: h * .065,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * .028),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: obsck,
                                style: GoogleFonts.lexend(
                                    color: Color(0xff9E9E9E),
                                    fontWeight: FontWeight.w500,
                                    fontSize: w * .035),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.lexend(
                                        color: Color(0xff9E9E9E),
                                        fontWeight: FontWeight.w500,
                                        fontSize: w * .035),
                                    suffixIcon: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          obsck = ! obsck;
                                        });
                                      },
                                      child: obsck?Icon(Icons.visibility):Icon(Icons.visibility_off),
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * .0275,
                          ),
                          InkWell(
                            onTap: (){
                              // getUser(email:signmailcontroller.text, password:signpasswardcontroller.text);
                              _loginUser();
                            },
                            child: Container(
                              height: h * .065,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: GoogleFonts.lexend(
                                      fontWeight: FontWeight.w500,
                                      fontSize: w * .055,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: h*0.02,),
                          InkWell(
                            onTap: (){
                              // auth1.loginUser;
                              auth1.signInWithGoogle(context);

                            },
                            child: Center(
                              child: Container(
                                width: double.infinity,
                                height: h * .065,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white
                                ),
                                // child: Image(image: AssetImage("assets/img/google_logo.webp"),
                                //   // fit: BoxFit.cover,
                                // ),
                                child: Image.network('https://play-lh.googleusercontent.com/1-hPxafOxdYpYZEOKzNIkS'
                                    'P43HXCNftVJVttoo4ucl7rsMASXW3Xr6GlXURCubE1tA=w3840-h2160-rw'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ));
                            },
                            child: Text(
                              'Sign up using Email',
                              style: GoogleFonts.lexend(
                                  fontSize: w * .039,
                                  decoration: TextDecoration.underline,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * .02,
                        ),
                        Center(
                          child: Text(
                            'By continuing, you agree to our\nTerms of Service Privacy Policy  Content Policy',
                            style: GoogleFonts.lexend(
                                fontSize: w * .025, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
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