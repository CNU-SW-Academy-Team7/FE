import 'package:flutter/material.dart';
import 'pages/appFirstPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
        ),
        useMaterial3: true,
        fontFamily: 'text',
      ),
      home: AppfirstPages(), // 첫 페이지를 AppfirstPages로 설정
      routes: {
        '/firstApp': (context) => AppfirstPages(),
      },
    );
  }
} 

