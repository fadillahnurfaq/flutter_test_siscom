import 'package:flutter/material.dart';

extension HideKeyboardExt on BuildContext {
  void hideKeyboard() {
    return FocusScope.of(this).unfocus();
  }
}
