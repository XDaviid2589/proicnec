import 'package:flutter/material.dart';

class ColorUtils {
  /// Devuelve negro o blanco dependiendo de qué contraste mejor con el color de fondo.
  static Color getContrastingColor(Color background) {
    // Fórmula de luminancia perceptiva
    final double luminance = background.computeLuminance();

    // Si es un color claro, usar negro; si es oscuro, usar blanco
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
