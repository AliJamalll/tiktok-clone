import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({super.key, required this.controller,  this.isObscure = false, required this.icon, required this.labelText});

  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:const  BorderSide(
            color: borderColor
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:const  BorderSide(
                color: borderColor
            )
        ),
      ),
      obscureText: isObscure,
    );
  }
}
