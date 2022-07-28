import 'package:flutter/material.dart';

class KeyboardHelper {
  static void dismissKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static bool detectKeyboardVisibility(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }
}
