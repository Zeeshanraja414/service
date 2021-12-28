import 'package:flutter/material.dart';

// class Constant{
//   static const String ApiAdress = 'http://192.168.26.115/OldHome1/api/oldhome/AllServicesImage?Imagee=Garden';
//   String api="http://192.168.10.6/OldHome1/api/oldhome";
// }
class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  String api = "http://192.168.10.11/OldHome1/api/oldhome";

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
