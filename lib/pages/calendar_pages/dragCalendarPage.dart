import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';



class DragCalendarPage extends StatefulWidget {
  final DateTime selectedDay;

  DragCalendarPage({super.key, required this.selectedDay});

  @override
  _DragCalendarPageState createState() => _DragCalendarPageState();
}

class _DragCalendarPageState extends State<DragCalendarPage> {
  final Set<int> selectedIndexes = Set<int>();
  final Set<int> selectedIndexes_Sun = Set<int>.from([9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97, 105, 113, 121, 129, 137, 145, 153, 161, 169]);
  final Set<int> selectedIndexes_Mon = Set<int>.from([10, 18, 26, 34, 42, 50, 58, 66, 74, 82, 90, 98, 106, 114, 122, 130, 138, 146, 154, 162, 170]);
  final Set<int> selectedIndexes_Tue = Set<int>.from([11, 19, 27, 35, 43, 51, 59, 67, 75, 83, 91, 99, 107, 115, 123, 131, 139, 147, 155, 163, 171]);
  final Set<int> selectedIndexes_Wed = Set<int>.from([12, 20, 28, 36, 44, 52, 60, 68, 76, 84, 92, 100, 108, 116, 124, 132, 140, 148, 156, 164, 172]);
  final Set<int> selectedIndexes_Thu = Set<int>.from([13, 21, 29, 37, 45, 53, 61, 69, 77, 85, 93, 101, 109, 117, 125, 133, 141, 149, 157, 165, 173]);
  final Set<int> selectedIndexes_Fri = Set<int>.from([14, 22, 30, 38, 46, 54, 62, 70, 78, 86, 94, 102, 110, 118, 126, 134, 142, 150, 158, 166, 174]);
  final Set<int> selectedIndexes_Sat = Set<int>.from([15, 23, 31, 39, 47, 55, 63, 71, 79, 87, 95, 103, 111, 119, 127, 135, 143, 151, 159, 167, 175]);
  final key = GlobalKey();
  final Set<_Foo> _trackTaped = Set<_Foo>();

  _detectTapedItem(PointerEvent event) {
    final RenderBox box =
        key.currentContext!.findAncestorRenderObjectOfType<RenderBox>()!;
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        final target = hit.target;
        if (target is _Foo && !_trackTaped.contains(target)) {
          _trackTaped.add(target);
          _toggleSelection(target.index);
          // print(selectedIndexes);
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
        // print(DateFormat('yyyy-MM-dd').format(widget.selectedDay));
        print(DateFormat('"yyyy-MM-dd').format(widget.selectedDay)+'-$time"');
        break;
      case 'MON':
        print(DateFormat('"yyyy-MM-dd').format(widget.selectedDay)+'-$time"');
        break;
      case 'TUE':
        print(DateFormat('"yyyy-MM-dd').format(widget.selectedDay)+'-$time"');
        break;
      case 'WED':
        print(DateFormat('"yyyy-MM-dd').format(widget.selectedDay)+'-$time"');
        break;
      case 'THU':
        print(DateFormat('"yyyy-MM-dd').format(widget.selectedDay)+'-$time"');
        break;
      case 'FRI':
        print(DateFormat('"yyyy-MM-dd').format(widget.selectedDay)+'-$time"');
        break;
      case 'SAT':
        print(DateFormat('"yyyy-MM-dd').format(widget.selectedDay)+'-$time"');
        break;
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _detectTapedItem,
      onPointerMove: _detectTapedItem,
      onPointerUp: _clearSelection,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0), // Add vertical padding
        child: GridView.builder(
          key: key,
          itemCount: 176, // Adjusted for header rows and columns
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: 3, // Adjusted aspect ratio for height
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
                    fontSize: 10,
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
                    '8:00PM'
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