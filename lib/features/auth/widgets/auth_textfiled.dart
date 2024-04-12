import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.hintText,
      required this.validator,
      this.inputFormatters = const [],
      this.keyboardType = TextInputType.text});
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
