import 'package:flutter/material.dart';

void main() {
  runApp(When2MeetApp());
}

class When2MeetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'When2Meet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MeetingScheduler(),
    );
  }
}

class MeetingScheduler extends StatefulWidget {
  @override
  _MeetingSchedulerState createState() => _MeetingSchedulerState();
}

class _MeetingSchedulerState extends State<MeetingScheduler> {
  List<DateTime> selectedTimes = [];

  void _toggleTime(DateTime time) {
    setState(() {
      if (selectedTimes.contains(time)) {
        selectedTimes.remove(time);
      } else {
        selectedTimes.add(time);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting Scheduler'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Available Times:',
              style: TextStyle(fontSize: 9),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 24,
              itemBuilder: (context, index) {
                int hour = index;
                DateTime time = DateTime(2023, 8, 11, hour);
                bool isSelected = selectedTimes.contains(time);

                return InkWell(
                  onTap: () => _toggleTime(time),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        hour.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // 여기서 선택된 시간을 서버로 전송하거나 다른 처리를 수행합니다.
                print('Selected Times: $selectedTimes');
              },
              child: Text('Schedule Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}