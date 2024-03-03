import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _emailController = TextEditingController();
  var _passController = TextEditingController();
  var _confirmPassController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  bool isEmail = true;
  bool isPass = true;
  bool isPassHide = true;
  bool isPassMatch = true;
  bool isConfirmPassHide = true;

  bool _isLoading = false;

  Future signUp() async {
    setState(() {
      _isLoading = true;
    });
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim());
      } catch (FirebaseAuthException) {
        print("Account is used!");
        setState(() {
          _isLoading = false;
        });
        var snackBar = SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          showCloseIcon: true,
          closeIconColor: Color.fromARGB(255, 183, 3, 3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          content: Row(
            children: [
              const Icon(
                Icons.report_problem_outlined,
                color: Color.fromARGB(255, 183, 3, 3),
              ),
              const SizedBox(width: 10),
              Text(
                'The Email is already used',
                style: GoogleFonts.robotoCondensed(
                    color: Color.fromARGB(255, 183, 3, 3),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Verification", style: GoogleFonts.robotoCondensed()),
            content: Text(
                "A verification email has sent to you, please check your mailbox and verfiy your account",
                style:
                    GoogleFonts.robotoCondensed(fontWeight: FontWeight.w500)),
            backgroundColor: Colors.grey[200],
            actions: [
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("signInScreen");
                    FirebaseAuth.instance.signOut();
                  },
                  color: Colors.blue,
                  child: Text("Continue",
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.white, fontWeight: FontWeight.w500)))
            ],
          );
        },
      );
      setState(() {
        _isLoading = false;
      });
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
            Form(
              key: formkey,
              child: Column(
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
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Email!';
                      }
                    },
                    decoration: InputDecoration(
                        //errorText: 'Please enter your Email',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        suffixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your Email',
                        hintStyle: GoogleFonts.robotoCondensed(),
                        errorText: isEmail ? null : 'Incorrect Email',
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
                    onChanged: (value) {
                      if (!emailRegex.hasMatch(value) || value.isEmpty) {
                        setState(() {
                          isEmail = false;
                        });
                      } else {
                        setState(() {
                          isEmail = true;
                        });
                      }
                    },
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
                  TextFormField(
                    controller: _passController,
                    obscureText: isPassHide,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPassHide = !isPassHide;
                              });
                            },
                            child: Icon(isPassHide
                                ? Icons.lock_outline
                                : Icons.lock_open)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your Password',
                        errorText: isPass
                            ? null
                            : 'Password must contain at least one letter, one digit, \nand be at least 8 characters long.',
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
                    onChanged: (value) {
                      if (!passwordRegex.hasMatch(value)) {
                        setState(() {
                          isPass = false;
                        });
                      } else {
                        setState(() {
                          isPass = true;
                        });
                      }
                    },
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
                  TextFormField(
                    controller: _confirmPassController,
                    obscureText: isConfirmPassHide,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPassHide = !isPassHide;
                              });
                            },
                            child: Icon(isPassHide
                                ? Icons.lock_outline
                                : Icons.lock_open)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Re-enter your password',
                        hintStyle: GoogleFonts.robotoCondensed(),
                        errorText:
                            isPassMatch ? null : 'Password doesn\'t match',
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
                    onChanged: (value) {
                      if (value != _passController.text) {
                        setState(() {
                          isPassMatch = false;
                        });
                      } else {
                        setState(() {
                          isPassMatch = true;
                        });
                      }
                    },
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
                        'Sign up',
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
