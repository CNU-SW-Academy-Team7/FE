import 'package:flutter/material.dart';
import 'login_signup_page/loginPage.dart';

class AppfirstPages extends StatefulWidget {
  @override
  _AppfirstPagesState createState() => _AppfirstPagesState();
}

class _AppfirstPagesState extends State<AppfirstPages> {
  @override
  void initState() {
    super.initState();
    // 1초 후에 로그인 페이지로 이동
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
