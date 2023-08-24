// import 'dart:ffi';

// import 'package:flutter/material.dart';

// //widgets
// import '../../../services/settingValues.dart';

// class SignUpTextFiled extends StatefulWidget {
//   final String label_text;
//   final bool obscureText_value;
//   final ValueChanged<String> onChangeFunc;

//   const SignUpTextFiled({
//     required this.label_text,
//     required this.obscureText_value,
//     required this.onChangeFunc

//   });

//   @override
//   State<StatefulWidget> createState() => SignUpTextFiledState();
// }

// class SignUpTextFiledState extends State<SignUpTextFiled> {


//   late String label_text;
//   late bool obscureText_value;
//   String _textFieldValue = '';

//   @override
//   void initState(){
//     super.initState();
//     label_text = widget.label_text;
//     obscureText_value = widget.obscureText_value;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Container(

//         child:Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(label_text,  style: TextStyle(
//                 color: Color(Primary),
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold
//             )),
//             Container(
//               height: 40,
//               margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
//               child: TextField(
//                 style: TextStyle(color: Color(Primary),
//                     fontSize: 12),
//                 onChanged: (value){
//                   setState(() {
//                     _textFieldValue = value;
//                   });
//                   widget.onChangeFunc(_textFieldValue);
//                 },
//                 obscureText: obscureText_value,
//                 decoration: InputDecoration(
//                   // labelText: label_text,
//                   // labelStyle: TextStyle(
//                   //     color: Color(Primary),
//                   //     fontSize: 12,
//                   //     fontWeight: FontWeight.bold
//                   // ),
//                   filled: true,
//                   fillColor: Color(SignUpTextField),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(22.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   focusedBorder:
//                   OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(Primary)),
//                   ),
//                 ),
//               ),
//             )
//           ],)

//     );
//   }


// }
