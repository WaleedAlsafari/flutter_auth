import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: Container(
          alignment: Alignment.center,
          child: FirebaseAuth.instance.currentUser!.emailVerified
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello you\'r signed in',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: signOut,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      child: Text(
                        'Sign out',
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.black, fontSize: 18),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () => FirebaseAuth.instance.currentUser!
                          .sendEmailVerification(),
                      color: Colors.amber,
                      height: 60,
                      child: Text(
                        'Please verfiy your Email',
                        style: GoogleFonts.robotoCondensed(fontSize: 16),
                      ),
                    ),
                  ],
                )),
    );
  }
}
