import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData iconprefix;
  final IconData iconsuffix;

  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.iconprefix,
    required this.iconsuffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconprefix),
        suffixIcon: Icon(iconsuffix),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
