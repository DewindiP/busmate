import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateTimeSelected;
  final DateTime? initialDateTime;

  const DateTimePickerWidget({
    super.key,
    required this.onDateTimeSelected,
    this.initialDateTime,
  });

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime ?? DateTime.now();
  }

  Future<void> _pickDateTime() async {
    // Pick date
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    if (!mounted) return;

    // Pick time
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
    );

    if (time == null) return;

    if (!mounted) return;

    // Combine date + time
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      selectedDateTime = dateTime;
    });


    widget.onDateTimeSelected(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final displayText = selectedDateTime != null
        ? DateFormat('yyyy-MM-dd – HH:mm').format(selectedDateTime!)
        : 'Select date & time';

    return InkWell(
      onTap: _pickDateTime,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Travel Date & Time',
          border: OutlineInputBorder(),
        ),
        child: Text(displayText),
      ),
    );
  }
}
