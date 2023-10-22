import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dragCalendarPage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MonthCalendarPage extends StatefulWidget {
  @override
  _MonthCalendarPageState createState() => _MonthCalendarPageState();
}

class _MonthCalendarPageState extends State<MonthCalendarPage> {
  final TextEditingController _scheduleController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Future<void> _showDateSelectionDialog(DateTime selectedDate) async {
    String groupId = '1';
    String scheduleId = '1';
    String scheduleName = '';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('선택된 날짜'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${selectedDate.month}월 ${selectedDate.day}일 ~ ${selectedDate.month}월 ${selectedDate.add(Duration(days: 6)).day}일 일정 생성',
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text('그룹 선택'),
                    SizedBox(width: 60),
                    DropdownButton<String>(
                      value: selectedGroup,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGroup = newValue!;
                        });
                      },
                      items: groupNames
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                TextField(
                    decoration: InputDecoration(
                      labelText: '스케쥴',
                      hintText: '스케쥴을 입력하세요',
                    ),
                    onChanged: (value) {
                      setState(() {
                        scheduleName = value;
                      });
                    }),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('아니요'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('생성'),
              onPressed: () async {
                // Generate a list of dates from selectedDate to selectedDate + 6 days.
                List<DateTime> selectedWeekDates = [];
                for (int i = 0; i < 7; i++) {
                  selectedWeekDates.add(selectedDate.add(Duration(days: i)));
                }
                print(selectedWeekDates);

                // Close the dialog and do something with the selected dates and group.
                Navigator.of(context)
                    .pop({'dates': selectedWeekDates, 'group': selectedGroup});

                final apiUrl = Uri.parse(
                    'http://34.64.52.102:8080/createGroupSchedule/${groupId}');

                try {
                  final response = await http.post(
                    apiUrl,
                    headers: {'Content-Type': 'application/json'},
                    body: json.encode({
                      'scheduleName': scheduleName,
                      'scheduleDate':
                          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                    }),
                  );

                  if (response.statusCode == 200) {
                    // 요청이 성공하고 서버에서 200 OK 응답을 받은 경우
                    print('요청 성공');
                    print('응답: ${response.body}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DragCalendarPage(selectedDay: selectedDate)),
                    );
                  } else {
                    // 요청이 실패한 경우
                    print('요청 실패');
                    print('응답 코드: ${response.statusCode}');
                  }
                } catch (error) {
                  // 예외 처리
                  print('오류 발생 : $error');
                }
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
      groupName: 'SW아카데미',
      scheduleName: '전체 미팅',
    ),
    CalendarEvent(
      date: DateTime(2023, 10, 2),
      groupName: 'FE',
      scheduleName: '프론트 미팅',
    ),
    // Add more events as needed
  ];

  // Define group names
  List<String> groupNames = ['SW아카데미', 'FE'];
  final List<Group> groups = [
    Group('SW아카데미', []),
    Group('FE', []),
  ];

  // Initialize the selected group with the first group in the list
  String selectedGroup = 'SW아카데미'; // 초기 선택값 설정

  @override
  Widget build(BuildContext context) {
    final User user = User('박용범', Icons.person);

    // groups를 필드 선언 시에 초기화합니다.

    groups[0].setItems(
        [user.name + '(나)', '김혜진', '김대민', '김솔', '이유현', '이태홍', '유정균', '서재환']);
    groups[1].setItems([user.name + '(나)', '이유현', '이태홍', '유정균']);

    return Scaffold(
      appBar: AppBar(
        title: Text('월별 일정'),
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
          Text('현재 일정'),
          SizedBox(height: 20),

          // Create a table to display calendar events
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('날짜')),
                DataColumn(label: Text('그룹')),
                DataColumn(label: Text('스케쥴')),
              ],
              rows: calendarEvents
                  .map(
                    (event) => DataRow(
                      cells: [
                        DataCell(Text(
                            DateFormat('MM월 dd일\nhh시 mm분').format(event.date))),
                        DataCell(Text(event.groupName)),
                        DataCell(Text(event.scheduleName)),
                      ],
                    ),
                  )
                  .toList(),
            ),
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
