import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();
  final TextEditingController _signUpUserNameController =
      TextEditingController();

  Future<void> _register() async {
    final String apiUrl = 'http://34.64.52.102:8080/signUp';

    final Map<String, dynamic> requestBody = {
      'userEmail': _signUpEmailController.text,
      'userPw': _signUpPasswordController.text,
      'userName': _signUpUserNameController.text,
    };

    print('User Email: ${_signUpEmailController.text}');
    print('User Password: ${_signUpPasswordController.text}');
    print('User Name: ${_signUpUserNameController.text}');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        // 회원 가입 성공
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('성공'),
              content: Text('회원 가입이 성공적으로 완료되었습니다.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      } else if (response.statusCode == 409) {
        final errorData = jsonDecode(response.body);
        // 이미 존재하는 사용자
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('에러'),
              content: Text('이미 존재하는 사용자입니다.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('닫기'),
                ),
              ],
            );
          },
        );
      } else {
        // 다른 오류 처리
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('에러'),
              content: Text('API 요청 중 오류 발생: ${response.statusCode}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('닫기'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // 예외 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('에러'),
            content: Text('API 요청 중 오류 발생: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('닫기'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _signUpEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _signUpPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _signUpUserNameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
