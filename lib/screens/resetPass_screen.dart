import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
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
            TextField()
          ],
        ),
      ),
    );
  }
}
