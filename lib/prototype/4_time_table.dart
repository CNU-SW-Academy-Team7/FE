import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Grid(),
    );
  }
}

class Grid extends StatefulWidget {
  @override
  GridState createState() {
    return new GridState();
  }
}

class GridState extends State<Grid> {
  final Set<int> selectedIndexes = Set<int>();
  final key = GlobalKey();
  final Set<_Foo> _trackTaped = Set<_Foo>();

  _detectTapedItem(PointerEvent event) {
    final RenderBox box = key.currentContext!.findAncestorRenderObjectOfType<RenderBox>()!;
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

  void _clearSelection(PointerUpEvent event) {
    setState(() {
      _trackTaped.clear();
    });
  }

  Widget _buildHeaderCell(String text) {
    return Expanded(
      child: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTimeCell(String text) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _detectTapedItem,
      onPointerMove: _detectTapedItem,
      onPointerUp: _clearSelection,
      child: Column(
        children: [
          // Weekday headers
          Row(
            children: [
              SizedBox(width: 70), // Empty cell for time headers
              _buildHeaderCell("Sun"),
              _buildHeaderCell("Mon"),
              _buildHeaderCell("Tue"),
              _buildHeaderCell("Wed"),
              _buildHeaderCell("Thu"),
              _buildHeaderCell("Fri"),
              _buildHeaderCell("Sat"),
            ],
          ),
          // Time columns
          Expanded(
            child: GridView.builder(
              key: key,
              itemCount: 7 * 24, // 7 days * 24 hours
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 7 days
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                if (index % 7 == 0) {
                  return _buildTimeCell("${(index ~/ 7) + 1}:00 AM");
                } else {
                  return Foo(
                    index: index,
                    child: Container(
                      color: selectedIndexes.contains(index) ? Colors.green : Colors.blue,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekdayName(int index) {
    List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekdays[index % 7];
  }
}

class Foo extends SingleChildRenderObjectWidget {
  final int index;

  Foo({required Widget child, required this.index, Key? key}) : super(child: child, key: key);

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
