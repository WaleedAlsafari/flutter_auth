import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  bool _isLoading = false;

  Future signIn() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(6),
                    width: 175,
                    height: 175,
                    child: Image.asset(
                      'images/leaf.png',
                      width: 60,
                      height: 60,
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Sign Up to create new account',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Email',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      suffixIcon: Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your Email',
                      hintStyle: GoogleFonts.robotoCondensed(),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 238, 238, 238),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Password',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      suffixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your Password',
                      hintStyle: GoogleFonts.robotoCondensed(),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 238, 238, 238),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                  Text(
                    'Password',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      suffixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your Password',
                      hintStyle: GoogleFonts.robotoCondensed(),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 238, 238, 238),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: signIn,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 248, 136, 8)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.fromLTRB(24, 30, 24, 18),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Sign in',
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not yet a member? ',
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  'Sign up now',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
