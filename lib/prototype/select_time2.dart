import 'package:flutter/material.dart';

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
  double _selectedHour = 0;
  double _selectedMinute = 0;
  double _startDragY = 0;

  void _onDragStart(DragStartDetails details) {
    _startDragY = details.localPosition.dy;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final dragOffset = details.localPosition.dy - _startDragY;
    final minutesPerPoint = 30 / 60; // 30분 간격

    final newMinute = _selectedMinute - dragOffset * minutesPerPoint;
    final newHour = _selectedHour + newMinute ~/ 60;
    final remainingMinutes = newMinute % 60;

    if (newHour >= 0 && newHour < 24 && remainingMinutes >= 0 && remainingMinutes < 60) {
      setState(() {
        _selectedHour = newHour;
        _selectedMinute = remainingMinutes;
      });
    }

    _startDragY = details.localPosition.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Selection Page'),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              height: 2500,
              child: GestureDetector(
                onVerticalDragStart: _onDragStart,
                onVerticalDragUpdate: _onDragUpdate,
                child: Column(
                  children: List.generate(48, (index) {
                    final hour = index ~/ 2;
                    final minute = (index % 2) * 30;
                    final isSelected = hour == _selectedHour && minute == _selectedMinute;

                    return Container(
                      height: 50,
                      color: isSelected ? Colors.blue : Colors.transparent,
                      child: Center(
                        child: Text(
                          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
                          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Selected Time: ${_selectedHour.toInt()}:${_selectedMinute.toInt().toString().padLeft(2, '0')}'),
          ],
        ),
      ),
    );
  }
}