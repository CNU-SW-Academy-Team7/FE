import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  List<DateTime> _selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새로운 페이지'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text('날짜를 선택해주세요 '),
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2050),
            selectedDayPredicate: (day) {
              return _selectedDates.contains(day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (_selectedDates.contains(selectedDay)) {
                  _selectedDates.remove(selectedDay);
                } else {
                  _selectedDates.add(selectedDay);
                }
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              selectedTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // 선택한 날짜 리스트를 출력
              print(_selectedDates);
            },
            child: Text('선택한 날짜 출력'),
          ),
          SizedBox(height: 20),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}