import 'package:flutter/material.dart';

class ColorUtils {
  static Color getContrastingColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  static bool isColorDark(Color color) {
    return color.computeLuminance() < 0.5;
  }

  static List<Color> filterColorsForTheme(
      List<Color> allColors, Brightness brightness) {
    return allColors.where((color) {
      final isDark = isColorDark(color);
      return brightness == Brightness.dark ? !isDark : isDark;
    }).toList();
  }

  static Color getRandomColorForTheme(
      List<Color> allColors, Brightness brightness) {
    final filtered = filterColorsForTheme(allColors, brightness);
    return (filtered..shuffle()).first;
  }
}
