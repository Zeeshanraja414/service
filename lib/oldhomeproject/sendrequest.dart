// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:old/oldhomeproject/login.dart';
// import 'package:http/http.dart' as http;
// import '../url.dart';
//
// class SendRequest extends StatefulWidget {
//   SendRequest({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _SendRequestState createState() => _SendRequestState();
// }
//
// class _SendRequestState extends State<SendRequest> {
//   late bool error, sending, success;
//   late String msg;
//   String url = "http://${IpAdress.ip}/OldHome1/api/oldhome/Sendrequestpost";
//   @override
//   void initState() {
//     error = false;
//     sending = false;
//     success = false;
//     super.initState();
//   }
//
//   Future<void> Request() async {
//     var res = await http.post(Uri.parse(url), body: {
//       'FullName': widget.FullName,
//       //   'PackageName': .text,
//       'Status': 'Pending',
//       'Id': widget.uid.toString(),
//       // 'Pid':    ,
//       'OHId': widget.Id.toString(),
//     });
//     if (res.statusCode == 200) {
//       print(res.body);
//       var data = json.decode(res.body);
//       if (data["error"]) {
//         setState(() {
//           sending = false;
//           error = true;
//           msg = data["message"];
//         });
//       } else {
//         widget.FullName = '';
//         widget.uid = '' as int;
//         widget.Id = '' as int;
//         setState(() {
//           sending = false;
//           success = true;
//         });
//       }
//     } else {
//       setState(() {
//         error = true;
//         msg = "Error during sending data";
//         sending = false;
//       });
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
