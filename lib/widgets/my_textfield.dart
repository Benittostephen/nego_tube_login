import 'package:flutter/material.dart';

import '../constants/const.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const MyTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIconConstraints:
            const BoxConstraints(minWidth: 40, minHeight: 20),
        filled: true,
        fillColor: primaryColor_50,
        hintText: hintText,
        hintStyle: TextStyle(color: primaryColor_300, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor_50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
