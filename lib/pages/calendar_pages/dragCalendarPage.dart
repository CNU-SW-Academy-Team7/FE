import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
// 백엔드와 연동하기 위해 import
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'resultCalendarPage.dart';
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Draggable Calendar'),
      ),
      body: DragCalendarPage(selectedDay: DateTime.now()),
    ),
  ));
}

class DragCalendarPage extends StatefulWidget {
  final DateTime selectedDay;

  DragCalendarPage({Key? key, required this.selectedDay}) : super(key: key);

  @override
  _DragCalendarPageState createState() => _DragCalendarPageState();
}

class _DragCalendarPageState extends State<DragCalendarPage> {
  final Set<int> selectedIndexes = Set<int>();
  final key = GlobalKey();
  final Set<_Foo> _trackTaped = Set<_Foo>();
  
  List<String> arrayList = [];
/////////////////////////////////////////////////////////////////////////////////////////////////////
//백엔드와 연동하는 부분
  void _connectToBackend() async {
  final baseUrl = 'http://34.64.52.102:8080';  // 실제 서버 주소로 변경
  final groupId = 'yourGroupId';
  final scheduleId = 'yourScheduleId';
  final userId = 'yourUserId';
  final url = Uri.parse('$baseUrl/availableSchedule/$groupId/$scheduleId/$userId');
  

  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(arrayList),
    );

    if (response.statusCode == 200) {
      print('요청 성공: ${response.body}');
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    print('에러 발생: $error');
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
    String time = '';

    if (index >= 9 && index <= 15) {
      time = '10:00:00';
    } else if (index >= 17 && index <= 23) {
      time = '10:30:00';
    } else if (index >= 25 && index <= 31) {
      time = '11:00:00';
    } else if (index >= 33 && index <= 39) {
      time = '11:30:00';
    } else if (index >= 41 && index <= 47) {
      time = '12:00:00';
    } else if (index >= 49 && index <= 55) {
      time = '12:30:00';
    } else if (index >= 57 && index <= 63) {
      time = '13:00:00';
    } else if (index >= 65 && index <= 71) {
      time = '13:30:00';
    } else if (index >= 73 && index <= 79) {
      time = '14:00:00';
    } else if (index >= 81 && index <= 87) {
      time = '14:30:00';
    } else if (index >= 89 && index <= 95) {
      time = '15:00:00';
    } else if (index >= 97 && index <= 103) {
      time = '15:30:00';
    } else if (index >= 105 && index <= 111) {
      time = '16:00:00';
    } else if (index >= 113 && index <= 119) {
      time = '16:30:00';
    } else if (index >= 121 && index <= 127) {
      time = '17:00:00';
    } else if (index >= 129 && index <= 135) {
      time = '17:30:00';
    } else if (index >= 137 && index <= 143) {
      time = '18:00:00';
    } else if (index >= 145 && index <= 151) {
      time = '18:30:00';
    } else if (index >= 153 && index <= 159) {
      time = '19:00:00';
    } else if (index >= 161 && index <= 167) {
      time = '19:30:00';
    } else if (index >= 169 && index <= 175) {
      time = '20:00:00';
    }

    
    
    String dayOfWeek = '';

    if (index >= 9 && index <= 169) {
      if (index % 8 == 1) {
        dayOfWeek = 'SUN';
      } else if (index % 8 == 2) {
        dayOfWeek = 'MON';
      } else if (index % 8 == 3) {
        dayOfWeek = 'TUE';
      } else if (index % 8 == 4) {
        dayOfWeek = 'WED';
      } else if (index % 8 == 5) {
        dayOfWeek = 'THU';
      } else if (index % 8 == 6) {
        dayOfWeek = 'FRI';
      } else if (index % 8 == 7) {
        dayOfWeek = 'SAT';
      }

      setState(() {
        if (selectedIndexes.contains(index)) {
          selectedIndexes.remove(index);
        } else {
          selectedIndexes.add(index);
        }
      });

      switch (dayOfWeek) {
        case 'SUN':
          arrayList.add(DateFormat('yyyy-MM-dd').format(widget.selectedDay) + '-$time"');
          break;
        case 'MON':
          arrayList.add(DateFormat('yyyy-MM-dd').format(widget.selectedDay) + '-$time"');
          break;
        case 'TUE':
          arrayList.add(DateFormat('yyyy-MM-dd').format(widget.selectedDay) + '-$time"');
          break;
        case 'WED':
          arrayList.add(DateFormat('yyyy-MM-dd').format(widget.selectedDay) + '-$time"');
          break;
        case 'THU':
          arrayList.add(DateFormat('yyyy-MM-dd').format(widget.selectedDay) + '-$time"');
          break;
        case 'FRI':
          arrayList.add(DateFormat('yyyy-MM-dd').format(widget.selectedDay) + '-$time"');
          break;
        case 'SAT':
          arrayList.add(DateFormat('yyyy-MM-dd').format(widget.selectedDay) + '-$time"');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          
        child: Listener(
          onPointerDown: (PointerDownEvent event) => _detectTapedItem(event),
          onPointerMove: (PointerMoveEvent event) => _detectTapedItem(event),
          onPointerUp: (PointerUpEvent event) => _clearSelection(event),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: GridView.builder(
              key: key,
              shrinkWrap: true, // 추가: GridView를 부모 위젯의 크기에 맞게 축소
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
                  return Foo(
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
        Container(
          
        child: ElevatedButton(
          onPressed: () {
            _connectToBackend(); //백엔드 연동 함수 호출
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResultCalendarPage(selectedDay: widget.selectedDay,))); //selectedDay 수정해야함
          },
          child: Text('Next'),
        ),
        ),
      ],
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
