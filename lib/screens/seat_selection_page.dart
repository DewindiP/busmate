import 'package:flutter/material.dart';
import '../services/database_service.dart';
import 'passenger_details_page.dart';
import '../widgets/seat.dart';

class SeatSelection extends StatefulWidget {
  final String route;
  final String date;
  final String bus;

  const SeatSelection({
    super.key,
    required this.route,
    required this.date,
    required this.bus,
  });

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  int? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Seat')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          final seatNo = index + 1;
          return FutureBuilder<bool>(
            future: DatabaseService.isSeatBooked(
                widget.route, widget.date, seatNo, widget.bus),
            builder: (context, snapshot) {
              final booked = snapshot.data ?? false;
              return SeatWidget(
                number: seatNo,
                booked: booked,
                selected: selectedSeat == seatNo,
                onTap: booked
                    ? null
                    : () => setState(() => selectedSeat = seatNo),
              );
            },
          );
        },
      ),
      floatingActionButton: selectedSeat == null
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PassengerDetails(
                      route: widget.route,
                      date: widget.date,
                      seat: selectedSeat!,
                      bus: widget.bus,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
