import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final DateTime selectedDate;       // Selected date
  final VoidCallback onTap;           // Open date picker

  const DatePicker({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true, // User cannot type manually
      onTap: onTap,   // Open date picker when tapped
      decoration: InputDecoration(
        labelText: 'Travel Date',
        hintText:
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
        suffixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
