import 'package:flutter/material.dart';
import 'package:old/dropdownforwaleed.dart';
import 'package:old/oldhomeproject/addservices.dart';
import 'package:old/oldhomeproject/admin.dart';
import 'package:old/oldhomeproject/login.dart';
import 'package:old/oldhomeproject/register.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      //'/add': (context) => const Multiimage(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const Signup(),
    },
  ));
}
