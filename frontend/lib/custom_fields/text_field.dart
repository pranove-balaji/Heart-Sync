import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData iconprefix;
  final IconData iconsuffix;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.iconprefix,
    required this.iconsuffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconprefix),
        suffixIcon: IconButton(
          icon: Icon(iconsuffix),
          onPressed: () {},
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
