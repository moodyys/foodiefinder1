import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myTextField extends StatelessWidget {
  const myTextField(
      {super.key,
      required this.hintText,
      required this.controller

      });

  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(

      decoration: InputDecoration(


        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}


