import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/util/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          // filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
