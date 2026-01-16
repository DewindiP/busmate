import 'package:flutter/material.dart';
import '../services/database_service.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: FutureBuilder(
        future: DatabaseService.getAllBookings(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final bookings = snapshot.data!;
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (_, i) {
              final b = bookings[i];
              return ListTile(
                title: Text('${b['route']} - Seat ${b['seat']}'),
                subtitle: Text('${b['passengerName']} (${b['phone']})'),
              );
            },
          );
        },
      ),
    );
  }
}
