import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool isEmail = true;
  bool isPassHide = true;
  bool isValidAccount = true;

  void _resetPass() {
    Navigator.of(context).pushNamed('resetPassScreen');
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool _isLoading = false;

  Future signIn() async {
    setState(() {
      isValidAccount = true;
      _isLoading = true;
    });
    if (_globalKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        print(FirebaseAuth.instance.currentUser!.emailVerified);
        if (!FirebaseAuth.instance.currentUser!.emailVerified) {
          FirebaseAuth.instance.currentUser!.sendEmailVerification();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:
                    Text("Verification", style: GoogleFonts.robotoCondensed()),
                content: Text(
                    "A verification email has sent to you, please check your mailbox and verfiy your account",
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w500)),
                backgroundColor: Colors.grey[200],
                actions: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed("signInScreen");
                        FirebaseAuth.instance.signOut();
                      },
                      color: Colors.blue,
                      child: Text("Continue",
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)))
                ],
              );
            },
          );
        }
        //Navigator.of(context).pushReplacementNamed('homeScreen');
      } catch (FirebaseAuthException) {
        print("Account is used!");
        setState(() {
          _isLoading = false;
        });
        showSnackBar("No such an account!", Icon(Icons.cancel));
      }
    }
  }

  void showSnackBar(String text, Icon icon) {
    var snackBar = SnackBar(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      showCloseIcon: true,
      closeIconColor: Color.fromARGB(255, 183, 3, 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      content: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Text(
            text,
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
              height: 20,
            ),
            Form(
              key: _globalKey,
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
                    'Sign In',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Sign in  to continue using the app',
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
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        suffixIcon: Icon(Icons.lock_outline),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: isValidAccount
                              ? null
                              : Text(
                                  "The Email or Password \nis incorrect",
                                  style: GoogleFonts.robotoCondensed(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                        ),
                        GestureDetector(
                          onTap: _resetPass,
                          child: Text(
                            'Reset your password',
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ElevatedButton(
                onPressed: signIn,
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 18)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 248, 136, 8)),
                    elevation: MaterialStateProperty.all(4)),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Sign in',
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: GoogleAuthButton(
                onPressed: signInWithGoogle,
                style: AuthButtonStyle(
                    elevation: 4,
                    buttonColor: Colors.white,
                    borderRadius: 30,
                    height: 60,
                    textStyle: GoogleFonts.robotoCondensed(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not yet a member?  ',
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed("signUpScreen"),
                  child: Text(
                    'Sign up now',
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
