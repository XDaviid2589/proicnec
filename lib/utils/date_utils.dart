import 'package:flutter/material.dart';

/// Muestra un selector de fecha personalizado con estilo
Future<DateTime?> showDatePickerDialog({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final now = DateTime.now();

  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime(2000),
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? now,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.primary, // header color
            onPrimary: Colors.white,                        // header text
            onSurface: Theme.of(context).colorScheme.onSurface, // body text
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
