import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 248, 136, 8),
        onPressed: () {
          Navigator.of(context).pushNamed('AddCategory');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
      body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 170),
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    Image.asset(
                      'images/folder.png',
                      scale: 4,
                    ),
                    Text('Company')
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    Image.asset(
                      'images/folder.png',
                      scale: 4,
                    ),
                    Text('Company')
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
