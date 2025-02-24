import 'package:flutter/material.dart';

void main() {
  runApp(const DayOfWeekApp());
}

class DayOfWeekApp extends StatelessWidget {
  const DayOfWeekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Days of the Week'),
        ),
        body: const DayOfWeekList(),
      ),
    );
  }
}

class DayOfWeekList extends StatelessWidget {
  const DayOfWeekList({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> days = [
      '월요일',
      '화요일',
      '수요일',
      '목요일',
      '금요일',
      '토요일',
      '일요일'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: days
            .map((day) => Container(
          width: 100,
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}