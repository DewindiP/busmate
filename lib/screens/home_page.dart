import 'package:flutter/material.dart';
import '../widgets/route_dropdown.dart';
import '../widgets/bus_dropdown.dart';
import 'seat_selection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedRoute = 'Colombo - Kandy';
  String selectedBus = '';
  String travelDate = '';

  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  // Open Date Picker
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        travelDate = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        dateController.text = travelDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Route dropdown
            RouteDropdown(
              selectedRoute: selectedRoute,
              onChanged: (value) {
                setState(() {
                  selectedRoute = value!;
                  selectedBus = ''; 
                });
              },
            ),
            const SizedBox(height: 16),

            // Bus dropdown
            BusDropdown(
              selectedBus: selectedBus,
              selectedRoute: selectedRoute,
              onChanged: (value) {
                setState(() {
                  selectedBus = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Date picker
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Travel Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: _pickDate,
            ),
            const SizedBox(height: 30),

            // Next button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedBus.isEmpty || travelDate.isEmpty)
                    ? null
                    : () {
                        // Navigate to seat selection
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SeatSelection(
                              route: selectedRoute,
                              date: travelDate,
                              bus: selectedBus,
                            ),
                          ),
                        );
                      },
                child: const Text('Select Seat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
