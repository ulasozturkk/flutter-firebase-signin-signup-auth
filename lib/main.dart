import 'package:denme/firebase_options.dart';
import 'package:denme/pages/auth/signin_page.dart';
import 'package:denme/pages/auth/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/loginpage" :(context) => const myLoginPage(),
        "/signup" :(context) =>  SignUpPage(),

      },
      home: const myLoginPage(),
    );
  }
}

