import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dragCalendarPage.dart';

class MonthCalendarPage extends StatefulWidget {
  @override
  _MonthCalendarPageState createState() => _MonthCalendarPageState();
}

class _MonthCalendarPageState extends State<MonthCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Future<void> _showDateSelectionDialog(DateTime selectedDate) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Date'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Making schedules ${selectedDate.day} to ${selectedDate.add(Duration(days: 6)).day} ???'),
              SizedBox(height: 20),
              Text('Select a Group:'),
              DropdownButton<String>(
                value: selectedGroup,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGroup = newValue!;
                  });
                },
                items: groupNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Nope'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sure'),
              onPressed: () {
                // Generate a list of dates from selectedDate to selectedDate + 6 days.
                List<DateTime> selectedWeekDates = [];
                for (int i = 0; i < 7; i++) {
                  selectedWeekDates.add(selectedDate.add(Duration(days: i)));
                }

                // Close the dialog and do something with the selected dates and group.
                Navigator.of(context).pop({'dates': selectedWeekDates, 'group': selectedGroup});
                print(selectedWeekDates);
                print(selectedGroup);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DragCalendarPage(selectedDay: _selectedDay)),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Define your calendar events here
  List<CalendarEvent> calendarEvents = [
    CalendarEvent(
      date: DateTime(2023, 10, 1),
      groupName: 'Group A',
      scheduleName: 'Event 1',
    ),
    CalendarEvent(
      date: DateTime(2023, 10, 2),
      groupName: 'Group B',
      scheduleName: 'Event 2',
    ),
    // Add more events as needed
  ];

  // Define group names
  List<String> groupNames = ['Group A', 'Group B'];
  final List<Group> groups = [
    Group('SW아카데미', []),
    Group('FE', []),
    ];

  // Initialize the selected group with the first group in the list
  String selectedGroup = 'Group A'; // 초기 선택값 설정

  @override
  Widget build(BuildContext context) {

    final User user = User('박용범', Icons.person);

    // groups를 필드 선언 시에 초기화합니다.
 

    groups[0].setItems([user.name + '(나)', '김혜진', '김대민', '김솔', '이유현', '이태홍', '유정균', '서재환']);
    groups[1].setItems([user.name + '(나)', '이유현', '이태홍', '유정균']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Month Calendar Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user.name),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                child: Icon(user.profileIcon),
              ),
            ),
            for (var group in groups)
              ExpansionTile(
                title: Text(group.name),
                children: [
                  for (var item in group.items)
                    ListTile(
                      title: Text(item),
                      onTap: () {
                        // 각 아이템을 클릭했을 때 수행할 작업을 여기에 추가
                      },
                    ),
                ],
              ),
          ],
        ),
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
              });

              // Show the date selection dialog when a date is selected.
              _showDateSelectionDialog(selectedDay);
            },
          ),
          SizedBox(height: 20),
          Text('Selected Date: ${_selectedDay.toLocal()}'),
          SizedBox(height: 20),

          // Create a table to display calendar events
          DataTable(
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Group Name')),
              DataColumn(label: Text('Schedule Name')),
            ],
            rows: calendarEvents
                .map(
                  (event) => DataRow(
                    cells: [
                      DataCell(Text(event.date.year.toString() + "-" + event.date.month.toString() +
                       "-" + event.date.day.toString())),
                      DataCell(Text(event.groupName)),
                      DataCell(Text(event.scheduleName)),
                    ],
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 20),

          // DropdownButton for selecting a group

        ],
      ),
    );
  }
}

class CalendarEvent {
  final DateTime date;
  final String groupName;
  final String scheduleName;

  CalendarEvent({
    required this.date,
    required this.groupName,
    required this.scheduleName,
  });
}

class User {
  final String name;
  final IconData profileIcon;

  User(this.name, this.profileIcon);
}

class Group {
  final String name;
  List<String> items; // 리스트 타입으로 변경

  Group(this.name, this.items);

  // 아이템 목록을 변경하는 메서드 추가
  void setItems(List<String> newItems) {
    items = newItems;
  }

}