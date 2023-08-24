import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DragCalendarPage extends StatefulWidget {
  @override
  _DragCalendarPageState createState() => _DragCalendarPageState();
}

class _DragCalendarPageState extends State<DragCalendarPage> {
  final Set<int> selectedIndexes = Set<int>();
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
    return Listener(
      onPointerDown: _detectTapedItem,
      onPointerMove: _detectTapedItem,
      onPointerUp: _clearSelection,
      child: GridView.builder(
        key: key,
        itemCount: 200, // Adjusted for header rows and columns
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          childAspectRatio: 5,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 2.0,
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
                  '8:30PM',
                  '9:00PM',
                  '9:30PM'
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
