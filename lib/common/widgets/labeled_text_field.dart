import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'ClashDisplay',
              color: Color(0xFF081C5D),
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            cursorColor: const Color(0xFF081C5D),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'PlusJakartaSans',
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF081C5D), width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF081C5D), width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
