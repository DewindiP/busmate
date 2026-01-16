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
      value: selectedRoute, 
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
        DropdownMenuItem(value: 'Colombo - Matara', child: Text('Colombo - Matara')),
        DropdownMenuItem(value: 'Colombo - Hambantota', child: Text('Colombo - Hambantota')),
        DropdownMenuItem(value: 'Colombo - Nuwara Eliya', child: Text('Colombo - Nuwara Eliya')),
        DropdownMenuItem(value: 'Colombo - Trincomalee', child: Text('Colombo - Trincomalee')),
        DropdownMenuItem(value: 'Colombo - kurunegala', child: Text('Colombo - kurunegala')),
        DropdownMenuItem(value: 'Colombo - Kegalle', child: Text('Colombo - Kegalle')),
        DropdownMenuItem(value: 'Colombo - Anuradhapura', child: Text('Colombo - Anuradhapura')),
      ],
      onChanged: onChanged, 
    );
  }
}
