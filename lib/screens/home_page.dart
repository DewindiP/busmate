import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/route_dropdown.dart';
import '../widgets/date_picker.dart';
import '../widgets/primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Default selected route
  String selectedRoute = 'Colombo - Kandy';

  // Default selected date (today)
  DateTime selectedDate = DateTime.now();

  // Function to show date picker
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    // If user selects a date, update state
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Blue-grey background like your UI images
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.directions_bus,
        size: 28,
        color: Colors.white,
      ),
        const SizedBox(width: 8),
      const Text('BusMate'),
    ],
  ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card container for clean UI
            Card(
              color: AppColors.card,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Route dropdown
                    RouteDropdown(
                      selectedRoute: selectedRoute,
                      onChanged: (value) {
                        setState(() {
                          selectedRoute = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Date picker
                    DatePicker(
                      selectedDate: selectedDate,
                      onTap: _pickDate,
                    ),

                    const SizedBox(height: 24),

                    // Continue button
                    PrimaryButton(
                      text: 'Continue',
                      onPressed: () {
                        // Later: navigate to seat selection screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Proceeding to seat selection'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
