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
  var _passController = TextEditingController();
  var _confirmPassController = TextEditingController();

  bool _isLoading = false;

  Future signUp() async {
    if (isPassMatch()) {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim());
      Navigator.of(context).pushNamed('/');
    } else {
      var snackBar = SnackBar(
        backgroundColor: Color.fromARGB(255, 147, 30, 30),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Row(
          children: [
            const Icon(
              Icons.report_problem_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              'Password doesn\'t match!',
              style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool isPassMatch() {
    if (_passController.text == _confirmPassController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
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
              height: 50,
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
                        suffixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your Email',
                        hintStyle: GoogleFonts.robotoCondensed(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 238, 238, 238),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 248, 136, 8)))),
                  ),
                  const SizedBox(
                    height: 12,
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
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        suffixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your Password',
                        hintStyle: GoogleFonts.robotoCondensed(),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 238, 238, 238),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 248, 136, 8)))),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Confirm Password',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _confirmPassController,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        suffixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Re-enter your password',
                        hintStyle: GoogleFonts.robotoCondensed(),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 238, 238, 238),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 248, 136, 8)))),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: signUp,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 248, 136, 8)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.fromLTRB(24, 30, 24, 18),
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
                  'Already have an account?  ',
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed("signInScreen"),
                  child: Text(
                    'Log in now',
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
