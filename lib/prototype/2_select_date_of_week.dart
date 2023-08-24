import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(TimeSelectionApp());
}

class TimeSelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Selection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimeSelectionPage(),
    );
  }
}

class TimeSelectionPage extends StatefulWidget {
  @override
  _TimeSelectionPageState createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<String> availableTimes = [
    '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM',
    '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Selection Page'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 6)),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Available Times for ${_selectedDay.toLocal().toString().split(' ')[0]}:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Wrap(
            children: availableTimes.map((time) {
              return InkWell(
                onTap: () {
                  // 여기서 시간 선택 처리를 수행하거나 원하는 동작을 수행할 수 있습니다.
                  print('Selected Time: $time');
                },
                child: Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}