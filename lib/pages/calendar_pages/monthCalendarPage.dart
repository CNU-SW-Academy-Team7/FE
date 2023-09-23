import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dragCalendarPage.dart';
import 'package:intl/intl.dart'; // intl 패키지를 임포트합니다.

class MonthCalendarPage extends StatefulWidget {
  @override
  _MonthCalendarPageState createState() => _MonthCalendarPageState();
}

class _MonthCalendarPageState extends State<MonthCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Month Calendar Page'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2023),
            lastDay: DateTime(2024),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                // print(DateFormat('yyyy-MM-dd').format(selectedDay)); // 원하는 형식으로 날짜 포맷
              });
            },
          ),
          SizedBox(height: 20),
          Text('Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDay)}'), // 원하는 형식으로 출력
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DragCalendarPage(selectedDay: _selectedDay)),
              );
            },
            child: Text('Drag Calendar Page'),
          ),
        ],
      ),
    );
  }
}