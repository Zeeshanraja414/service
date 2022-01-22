// @dart=2.9
import 'package:flutter/material.dart';
import 'package:old/Rating.dart';
import 'package:old/date.dart';
import 'package:old/oldhomeproject/login.dart';
import 'package:old/oldhomeproject/register.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/app': (context) => RatingsWidget(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const Signup(),
    },
  ));
}
