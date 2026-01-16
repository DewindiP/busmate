import 'package:flutter/material.dart';

class BusDropdown extends StatelessWidget {
  final String selectedBus;
  final Function(String?) onChanged;
  final String selectedRoute;

  const BusDropdown({
    super.key,
    required this.selectedBus,
    required this.onChanged,
    required this.selectedRoute,
  });

  // Generate buses from 5:00 AM to 10:00 PM every hour
  List<String> _generateBuses(String route) {
    List<String> buses = [];
    for (int hour = 5; hour <= 22; hour++) {
      final timeString = '${hour.toString().padLeft(2, '0')}:00';
      buses.add('$route at $timeString');
    }
    return buses;
  }

  @override
  Widget build(BuildContext context) {
    final busList = _generateBuses(selectedRoute);

    return DropdownButtonFormField<String>(
      value: selectedBus.isEmpty ? null : selectedBus,
      decoration: InputDecoration(
        labelText: 'Select Bus',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: busList
          .map(
            (bus) => DropdownMenuItem<String>(
              value: bus,
              child: Text(bus),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
