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

  /////////////////////////////////////////////////////////////////////////////////////////////////////
//백엔드와 연동하는 부분
  Future<void> registerUser() async {
  final apiUrl = '34.64.52.102:8080/availableScheduleResult/1/2'; // 백엔드 API URL
  final requestBody = {
    'email': 'user@example.com',
    'password': 'password123',
    // 다른 필요한 데이터도 추가할 수 있음
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    // 회원 가입 성공
    final responseData = jsonDecode(response.body);
    // 응답 데이터를 처리하는 로직 추가
  } else {
    // 회원 가입 실패 또는 오류 처리
    final errorMessage = '회원 가입에 실패했습니다.';
    // 오류 처리 로직 추가
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////

  _detectTapedItem(PointerEvent event) {
    if (event.position != null) {
      final RenderBox box =
          key.currentContext!.findRenderObject() as RenderBox;
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
          child: Listener(
            onPointerDown: _detectTapedItem,
            onPointerMove: _detectTapedItem,
            onPointerUp: _clearSelection,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: GridView.builder(
                key: key,
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
                        ['', 'SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'][index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    );
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
                      ),
                    );
                  } else {
                    return  Foo(
                      index: index,
                      child: Container(
                        color: selectedIndexes.contains(index)
                            ? Colors.green
                            : Colors.grey,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 1.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // 외곽선 색상 설정
              width: 3.0, // 외곽선의 너비 설정
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
              SizedBox(height: 10.0), // 줄 사이의 간격 추가
              Divider(
                color: Colors.black, // 구분선 색상 설정
                thickness: 3.0, // 구분선의 두께 설정
              ),
              SizedBox(height: 10.0), // 줄 사이의 간격 추가
               Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '가능 시간 표시',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green, //주석처리처럼 초록색 해놓은거
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



  void _clearSelection(PointerUpEvent event) {
    setState(() {
      _trackTaped.clear();
    });
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
