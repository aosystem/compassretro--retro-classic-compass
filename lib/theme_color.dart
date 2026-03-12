import 'package:flutter/material.dart';

import 'model.dart';

class ThemeColor {
  final int? themeNumber;
  final BuildContext context;

  ThemeColor({this.themeNumber, required this.context});

  Brightness get _effectiveBrightness {
    switch (themeNumber) {
      case 1:
        return Brightness.light;
      case 2:
        return Brightness.dark;
      default:
        return Theme.of(context).brightness;
    }
  }

  bool get _isLight => _effectiveBrightness == Brightness.light;

  //main
  Color get mainForeColor => _isLight ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(255, 255, 255, 0.7);
  //main image
  String get compassBody {
    String body = 'assets/image/compass_body.webp';
    if (Model.themeImage == 1) {
      body = _isLight ? 'assets/image/compass_body.webp' : 'assets/image/compass_body_dark.webp';
    } else if (Model.themeImage == 2) {
      body = _isLight ? 'assets/image/compass_body02.webp' : 'assets/image/compass_body02_dark.webp';
    } else if (Model.themeImage == 3) {
      body = _isLight ? 'assets/image/compass_body03.webp' : 'assets/image/compass_body03_dark.webp';
    } else if (Model.themeImage == 4) {
      body = _isLight ? 'assets/image/compass_body04.webp' : 'assets/image/compass_body04_dark.webp';
    }
    return body;
  }
  String get compassNeedle {
    String needle = 'assets/image/compass_needle.webp';
    if (Model.themeImage == 1) {
      needle = _isLight ? 'assets/image/compass_needle.webp' : 'assets/image/compass_needle_dark.webp';
    } else if (Model.themeImage == 2) {
      needle = 'assets/image/compass_needle02.webp';
    } else if (Model.themeImage == 3) {
      needle = 'assets/image/compass_needle02.webp';
    } else if (Model.themeImage == 4) {
      needle = 'assets/image/compass_needle02.webp';
    }
    return needle;
  }
  //setting
  Color get backColor => _isLight ? Colors.grey[200]! : Colors.grey[900]!;
  Color get cardColor => _isLight ? Colors.white : Colors.grey[800]!;
  Color get appBarForegroundColor => _isLight ? Colors.grey[700]! : Colors.white70;
  Color get dropdownColor => cardColor;
  Color get backColorMono => _isLight ? Colors.white : Colors.black;
  Color get foreColorMono => _isLight ? Colors.black : Colors.white;

}
