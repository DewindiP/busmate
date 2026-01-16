import 'package:flutter/material.dart';
import '../services/database_service.dart';
import 'booking_confirmation_page.dart';

class PassengerDetails extends StatefulWidget {
  final String route, date;
  final int seat;
  final String bus;

  const PassengerDetails({
    super.key,
    required this.route,
    required this.date,
    required this.seat,
    required this.bus,
  });

  @override
  State<PassengerDetails> createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  bool isLoading = false; // show loading indicator

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _confirmBooking() async {
    if (nameCtrl.text.isEmpty || phoneCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();

      // Save seat and booking in database
      await DatabaseService.bookSeat(widget.route, widget.date, widget.seat, widget.bus);
      await DatabaseService.saveBooking({
        'id': id,
        'route': widget.route,
        'date': widget.date,
        'seat': widget.seat,
        'bus': widget.bus,
        'passengerName': nameCtrl.text,
        'phone': phoneCtrl.text,
      });

      
      if (!mounted) return;

      // Navigate to booking confirmation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BookingConfirmation(bookingId: id),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Passenger Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const Spacer(),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _confirmBooking,
                      child: const Text('Confirm Booking'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
