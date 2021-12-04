import 'package:flutter/material.dart';
import 'package:old/addservices.dart';
import 'package:old/login.dart';
import 'package:old/register.dart';
import 'admin.dart';





void main() {
  runApp(MaterialApp(
    initialRoute: '/admin',
    routes: {
      'add':(context)=>const Multiimage(),
      '/login':(context)=>const LoginPage(),
      '/register':(context)=>const Signup(),
      '/admin':(context)=>const Admin(),
     // '/details':(context)=>Details(),

    },
  ));
}