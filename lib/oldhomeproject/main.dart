// @dart=2.9
import 'package:flutter/material.dart';
import 'package:old/Rating.dart';
import 'package:old/Table.dart';
import 'package:old/oldhomeproject/login.dart';
import 'package:old/oldhomeproject/register.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/appoint': (context) => Table11(),
      '/app': (context) => RatingsWidget(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const Signup(),
    },
  ));
}
