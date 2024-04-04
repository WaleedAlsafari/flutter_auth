import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/Auth.dart';
import 'package:flutter_auth/categories/add.dart';
import 'package:flutter_auth/screens/home_screen.dart';
import 'package:flutter_auth/screens/resetPass_screen.dart';
import 'package:flutter_auth/screens/sign_in_screen.dart';
import 'package:flutter_auth/screens/sign_up_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA40wpCF1U9Ee4BJ6rBtIAPU4O2VvCuk2U",
          appId: "1:1004123463661:android:ea7e2708edff7ac50a51e4",
          messagingSenderId: "1004123463661	",
          projectId: "fir-auth-app-4c036"));
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              elevation: 2,
              backgroundColor: const Color.fromARGB(255, 248, 136, 8),
              shadowColor: Colors.black,
              titleTextStyle: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22))),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        'homeScreen': (context) => const HomeScreen(),
        'signInScreen': (context) => const SigninScreen(),
        'signUpScreen': (context) => const SignupScreen(),
        'resetPassScreen': (context) => const ResetPassScreen(),
        'AddCategory': (context) => const AddCategory(),
      },
    );
  }
}
