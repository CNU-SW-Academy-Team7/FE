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


// 업로드를 위해 수정





// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login() {
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     // Implement login logic
//     print('Email: $email, Password: $password');
//   }

//   void _signUp() {
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     // Navigate to the SignUpPage
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SignUpPage()),
//     );
//   }

//   void _loginWithGoogle() {
//     // Implement Google login logic
//     print('Logging in with Google');
//   }

//   @override
//   Widget build(BuildContext context) {
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
//                     Icons.verified_user, // Standard Google icon
//                     size: 36.0,
//                     color: Colors.red, // Set the desired color
//                   ),
//                 ),
//                 SizedBox(width: 10.0), // Add spacing
//                 IconButton(
//                   onPressed: () {
//                     // Implement Samsung login logic
//                     print('Logging in with Samsung');
//                   },
//                   icon: Icon(
//                     Icons.phone_android, // Standard Samsung icon
//                     size: 36.0,
//                     color: Colors.blue, // Set the desired color
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SignUpPage extends StatelessWidget {
//   final TextEditingController _signUpEmailController = TextEditingController();
//   final TextEditingController _signUpPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   void _register() {
//     String email = _signUpEmailController.text;
//     String password = _signUpPasswordController.text;
//     String confirmPassword = _confirmPasswordController.text;

//     // Implement registration logic
//     print('Email: $email, Password: $password, Confirm Password: $confirmPassword');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _signUpEmailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _signUpPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _register,
//               child: Text('Register'),
//             ),
//             SizedBox(height: 16.0),
//             Text('Or sign up with:'),
//             SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     // Implement Google sign-up logic
//                     print('Signing up with Google');
//                   },
//                   icon: Icon(
//                     Icons.verified_user,
//                     size: 36.0,
//                     color: Colors.red,
//                   ),
//                 ),
//                 SizedBox(width: 10.0),
//                 IconButton(
//                   onPressed: () {
//                     // Implement Samsung sign-up logic
//                     print('Signing up with Samsung');
//                   },
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
// }