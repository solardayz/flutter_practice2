import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class DayOfWeekList extends StatefulWidget {
  const DayOfWeekList({super.key});

  @override
  DayOfWeekListState createState() => DayOfWeekListState();
}

class DayOfWeekListState extends State<DayOfWeekList> {
  bool _isBottomSheetVisible = false;
  final GlobalKey _mondayKey = GlobalKey();
  final List<String> subjects = ['영어', '수학', '국어', '과학', '체육', '음악', '기술'];
  final List<String> daysOfWeek = ['월', '화', '수', '목', '금'];
  Map<String, List<String>> timetable = {};

  @override
  void initState() {
    super.initState();
    _generateTimetable();
  }

  void _generateTimetable() {
    final random = Random();
    for (String day in daysOfWeek) {
      List<String> daySubjects = [];
      for (int i = 0; i < 10; i++) {
        if (random.nextBool()) {
          daySubjects.add(subjects[random.nextInt(subjects.length)]);
        } else {
          daySubjects.add(''); // 공백 추가
        }
      }
      timetable[day] = daySubjects;
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showBottomSheet(BuildContext context, String selectedDay) {
    final RenderBox renderBox =
    _mondayKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double y = offset.dy + renderBox.size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      _isBottomSheetVisible = true;
    });

    Overlay.of(context).insert(
      OverlayEntry(
        builder: (BuildContext context) {
          return Positioned(
            left: 0,
            top: y,
            width: screenWidth,
            height: screenHeight - y,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isBottomSheetVisible = false;
                });
              },
              child: Material(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      final String dayKey = selectedDay.substring(0, 1);
                      if (timetable.containsKey(dayKey) &&
                          timetable[dayKey] != null &&
                          index < timetable[dayKey]!.length) {
                        return Container(
                          height: 50,
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.blue[100],
                          child: Center(
                              child: Text(timetable[dayKey]![index])),
                        );
                      } else {
                        return Container(
                          height: 50,
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.grey[300],
                          child: const Center(child: Text('')),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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
            .map((day) => GestureDetector(
          onTap: () {
            if (daysOfWeek.contains(day.substring(0, 1))) {
              _showBottomSheet(context, day);
            }
          },
          child: Container(
            key: day == '월요일' ? _mondayKey : null,
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
          ),
        ))
            .toList(),
      ),
    );
  }
}