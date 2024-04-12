import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}

extension NumExt on num {
  SizedBox get hBox => SizedBox(height: toDouble());
  SizedBox get wBox => SizedBox(width: toDouble());
  SizedBox get hwBox => SizedBox(
        width: toDouble(),
        height: toDouble(),
      );
}
