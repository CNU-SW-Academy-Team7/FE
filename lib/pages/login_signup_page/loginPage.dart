import 'package:flutter/material.dart';

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

            SizedBox(height: 10.0), // Add spacing
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
                SizedBox(width: 10.0), // Add spacing
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

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Implement login logic
    print('Email: $email, Password: $password');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MonthCalendarPage()));
  }

  void _signUp() {
    // Navigate to the SignUpPage
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void _loginWithGoogle() {
    // Implement Google login logic
    print('Logging in with Google');
  }

  void _loginWithSamsung() {
    // Implement Samsung login logic
    print('Logging in with Samsung');
  }
}

// import 'package:flutter/material.dart';
// import 'signupPage.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   late BuildContext _pageContext; // Declare a BuildContext variable

//   @override
//   Widget build(BuildContext context) {
//     _pageContext = context; // Store the context

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _login,
//                   child: Text('Login'),
//                 ),
//                 SizedBox(width: 10.0),
//                 ElevatedButton(
//                   onPressed: _signUp,
//                   child: Text('SIGN UP'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10.0), // Add spacing
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: _loginWithGoogle,
//                   icon: Icon(
//                     Icons.verified_user,
//                     size: 36.0,
//                     color: Colors.red,
//                   ),
//                 ),
//                 SizedBox(width: 10.0), // Add spacing
//                 IconButton(
//                   onPressed: _loginWithSamsung,
//                   icon: Icon(
//                     Icons.phone_android,
//                     size: 36.0,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _login() {
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     // Implement login logic
//     print('Email: $email, Password: $password');
//   }

//   void _signUp() {
//     // Navigate to the SignUpPage
//     Navigator.push(_pageContext, MaterialPageRoute(builder: (context) => SignUpPage()));
//   }

//   void _loginWithGoogle() {
//     // Implement Google login logic
//     print('Logging in with Google');
//   }

//   void _loginWithSamsung() {
//     // Implement Samsung login logic
//     print('Logging in with Samsung');
//   }
// }