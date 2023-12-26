import 'package:flutter/material.dart';

enum AppColor { green, blue, red, deepPurple }

extension AppColorExtension on AppColor {
  MaterialColor get color {
    switch (this) {
      case AppColor.green:
        return Colors.green;
      case AppColor.blue:
        return Colors.blue;
      case AppColor.red:
        return Colors.red;
      case AppColor.deepPurple:
        return Colors.deepPurple;
    }
  }
}
