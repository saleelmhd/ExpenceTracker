import 'package:expensenote/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';// Import Firebase Core

import 'core/globel_variable.dart';
import 'firebase_options.dart';
// import 'firebase_options.dart';

Future<void> main() async {
// ...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpenseNote',
      home: SplashScreen(),
    
   
    );
  }
}
