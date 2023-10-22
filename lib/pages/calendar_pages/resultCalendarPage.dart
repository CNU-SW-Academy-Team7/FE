import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultCalendarPage extends StatefulWidget {
  final DateTime selectedDay;

  ResultCalendarPage({Key? key, required this.selectedDay}) : super(key: key);

  @override
  _ResultCalendarPageState createState() => _ResultCalendarPageState();
}

class _ResultCalendarPageState extends State<ResultCalendarPage> {
  final Set<int> selectedIndexes = Set<int>();
  final key = GlobalKey();
  final Set<_Foo> _trackTaped = Set<_Foo>();
  List<Map<String, dynamic>> availableScheduleList = [];

  @override
  void initState() {
    super.initState();
    // 백엔드에서 데이터를 가져와서 availableScheduleList를 초기화
    fetchAvailableSchedules();
  }

  // 백엔드와 연동하는 부분
  Future<void> fetchAvailableSchedules() async {
    final apiUrl = '34.64.52.102:8080/availableScheduleList/1/1';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final availableSchedules = jsonBody['availableScheduleResponseList'];

      if (availableSchedules is List) {
        // 데이터를 맵으로 파싱한 다음 availableScheduleList에 설정
        setState(() {
          availableScheduleList =
              availableSchedules.cast<Map<String, dynamic>>();
        });
      }
    }
  }

  // Detecting tapped item
  _detectTapedItem(PointerEvent event) {
    if (event.position != null) {
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
      final result = BoxHitTestResult();
      Offset local = box.globalToLocal(event.position!);
      if (box.hitTest(result, position: local)) {
        for (final hit in result.path) {
          final target = hit.target;
          if (target is _Foo && !_trackTaped.contains(target)) {
            _trackTaped.add(target);
            _toggleSelection(target.index);
          }
        }
      }
    }
  }

  // Toggling selection
  _toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Calendar Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 176,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 3,
                crossAxisSpacing: 0.5,
                mainAxisSpacing: 0.0,
              ),
              itemBuilder: (context, index) {
                if (index < 8) {
                  return Container(
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text(
                        [
                          '',
                          'SUN',
                          'MON',
                          'TUE',
                          'WED',
                          'THU',
                          'FRI',
                          'SAT'
                        ][index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ));
                } else if (index % 8 == 0) {
                  return Container(
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text(
                        [
                          '10:00AM',
                          '10:30AM',
                          '11:00AM',
                          '11:30AM',
                          '12:00PM',
                          '12:30PM',
                          '1:00PM',
                          '1:30PM',
                          '2:00PM',
                          '2:30PM',
                          '3:00PM',
                          '3:30PM',
                          '4:00PM',
                          '4:30PM',
                          '5:00PM',
                          '5:30PM',
                          '6:00PM',
                          '6:30PM',
                          '7:00PM',
                          '7:30PM',
                          '8:00PM',
                        ][(index ~/ 8) - 1],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ));
                } else {
                  // 여기서 availableNum 값을 가져와야 합니다.
                  final availableNum = availableScheduleList.isNotEmpty
                      ? availableScheduleList[index - 8]['availableNum'] as int
                      : 0; // 임시로 0으로 설정

                  // 색상을 availableNum에 따라 동적으로 설정
                  final maxAvailableNum = availableScheduleList.isNotEmpty
                      ? availableScheduleList
                          .map((data) => data['availableNum'] as int)
                          .reduce((a, b) => a > b ? a : b)
                      : 0; // 가장 큰 availableNum 값

                  final color = availableNum > 0
                      ? Colors.green.withOpacity(
                          0.1 + (availableNum / maxAvailableNum) * 0.9)
                      : Colors.grey;

                  return Container(
                    color: color,
                  );
                }
              },
            ),
          ),
          SizedBox(height: 1.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '가능 시간',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: Colors.black,
                  thickness: 3.0,
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '가능 시간 표시',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Foo extends SingleChildRenderObjectWidget {
  final int index;

  Foo({required Widget child, required this.index, Key? key})
      : super(child: child, key: key);

  @override
  _Foo createRenderObject(BuildContext context) {
    return _Foo(index);
  }

  @override
  void updateRenderObject(BuildContext context, _Foo renderObject) {
    renderObject..index = index;
  }
}

class _Foo extends RenderProxyBox {
  int index;
  _Foo(this.index);
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Draggable Calendar'),
      ),
      body: ResultCalendarPage(selectedDay: DateTime.now()),
    ),
  ));
}