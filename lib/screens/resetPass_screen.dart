import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  var _emailController = TextEditingController();
  var msg = '';

  void sendResetPass() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text);
    setState(() {
      msg =
          'Check You\'r Email box, if the Email is valid you will receive the Email Message';
    });
  }

  @override
  void initState() {
    msg = '';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Back',
          style: GoogleFonts.robotoCondensed(fontSize: 24),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'Enter Your Email',
              style: GoogleFonts.robotoCondensed(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'someone@abc123.com',
                  hintStyle: GoogleFonts.robotoCondensed(),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 238, 238, 238),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 248, 136, 8)))),
            ),
            GestureDetector(
              onTap: sendResetPass,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 248, 136, 8)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.fromLTRB(24, 30, 24, 18),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Sign in',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              msg,
              style: GoogleFonts.robotoCondensed(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
