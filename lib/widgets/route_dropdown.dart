import 'package:flutter/material.dart';

class RouteDropdown extends StatelessWidget {
  final String selectedRoute;                // Currently selected route
  final Function(String?) onChanged;         // Called when route changes

  const RouteDropdown({
    super.key,
    required this.selectedRoute,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedRoute, // Default selected value
      decoration: InputDecoration(
        labelText: 'Select Route', // Field label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'Colombo - Kandy', child: Text('Colombo - Kandy')),
        DropdownMenuItem(value: 'Colombo - Galle', child: Text('Colombo - Galle')),
        DropdownMenuItem(value: 'Colombo - Jaffna', child: Text('Colombo - Jaffna')),
      ],
      onChanged: onChanged, // Trigger when user selects
    );
  }
}
