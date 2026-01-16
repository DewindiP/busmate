import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class SeatWidget extends StatelessWidget {
  final int number;
  final bool booked;
  final bool selected;
  final VoidCallback? onTap;

  const SeatWidget({
    super.key,
    required this.number,
    required this.booked,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color = booked
        ? AppColors.bookedSeat
        : selected
            ? AppColors.selectedSeat
            : AppColors.availableSeat;

    return GestureDetector(
      onTap: booked ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('Seat $number', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
