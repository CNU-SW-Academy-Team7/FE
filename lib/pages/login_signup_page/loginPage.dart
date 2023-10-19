import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'signupPage.dart';
import '/pages/calendar_pages/monthCalendarPage.dart';
import '/widgets/login_page_widgets/loginPageTextField.dart';
import '/widgets/login_page_widgets/loginPageButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    final apiUrl = Uri.parse('http://34.64.52.102:8080/signIn');

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userEmail': email,
          'userPw': password,
        }),
      );

      print("response body : ${response.body}");
      print("response : ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        int userId = responseData['userId'];

        print('로그인 성공! 사용자 ID: ${userId}');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MonthCalendarPage()),
        );
      } else {
        print('로그인 실패. HTTP 상태 코드: ${response.statusCode}');
        // 실패 시 사용자에게 알려줄 수 있는 메시지 출력 또는 처리
        print(email);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('로그인 실패'),
              content: Text('로그인에 실패했습니다.\n이메일과 비밀번호를 확인해주세요.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('오류 발생: $error');
      // 오류 처리
    }
  }

  void _signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  void _loginWithGoogle() {
    print('Logging in with Google');
    // Google 로그인 로직 추가
  }

  void _loginWithSamsung() {
    print('Logging in with Samsung');
    // Samsung 로그인 로직 추가
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginPageTextField(
              labelText: 'Email',
              controller: _emailController,
            ),
            SizedBox(height: 16.0),
            LoginPageTextField(
              labelText: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginButton(
                  text: 'Login',
                  onPressed: _login,
                ),
                SizedBox(width: 10.0),
                LoginButton(
                  text: 'SIGN UP',
                  onPressed: _signUp,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _loginWithGoogle,
                  icon: Icon(
                    Icons.verified_user,
                    size: 36.0,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 10.0),
                IconButton(
                  onPressed: _loginWithSamsung,
                  icon: Icon(
                    Icons.phone_android,
                    size: 36.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}