import 'package:flutter/material.dart';
import 'package:old/date.dart';
import 'package:old/oldhomeproject/login.dart';
import 'package:old/oldhomeproject/register.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/app': (context) => const Appointment(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const Signup(),
    },
  ));
}
