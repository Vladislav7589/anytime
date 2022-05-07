import 'package:flutter/material.dart';
import 'dart:math';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Color(0xDF290505),
  primary: Color(0xDF290505),
  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 2),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  textStyle: TextStyle(fontSize: 18),
  onPrimary: Color.fromARGB(255, 40, 43, 40),
  primary: Color.fromARGB(255, 144, 190, 109),
  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 2),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);