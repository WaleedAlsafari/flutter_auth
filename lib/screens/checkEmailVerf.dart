import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Simulate loading for 5 seconds
    await Future.delayed(Duration(seconds: 5));

    // Check if user's email is verified
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      // Navigate to home screen
      Navigator.of(context).pushReplacementNamed('homeScreen');
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loader Screen'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Loader circle
            : Text('Email not verified or user not logged in'),
      ),
    );
  }
}
