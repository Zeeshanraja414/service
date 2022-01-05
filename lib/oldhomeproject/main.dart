import 'package:flutter/material.dart';
import 'package:old/oldhomeproject/login.dart';
import 'package:old/oldhomeproject/register.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => const LoginPage(),
      '/register': (context) => const Signup(),
    },
  ));
}
