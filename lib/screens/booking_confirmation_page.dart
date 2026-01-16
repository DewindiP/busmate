import 'package:flutter/material.dart';

class BookingConfirmation extends StatelessWidget {
  final String bookingId;

  const BookingConfirmation({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text('Booking Confirmed'),
            Text('Booking ID: $bookingId'),
          ],
        ),
      ),
    );
  }
}
