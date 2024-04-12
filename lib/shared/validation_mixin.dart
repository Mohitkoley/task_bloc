import 'package:flutter/services.dart';

String mobile = "9033006262";
String password = "eVital@12";

mixin ValidationMixin {
  String? checkPhone(String? value) {
    if (value == null || value.isEmpty) {
      return "phone number cannot be empty";
    } else if (value != mobile) {
      return "phone is not invalid";
    }
    return null;
  }

  String? checkPassword(String? value) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    } else if (value != password) {
      return "Password is invalid";
    }
    return null;
  }

  List<TextInputFormatter> get phoneFormatter => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];
}
