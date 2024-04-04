import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  CustomMaterialButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 248, 136, 8),
      textColor: Colors.white,
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
