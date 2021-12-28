import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: 600,
              child: Image.asset(
                'assets/r1.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 300,
              width: 600,
              child: Image.asset(
                'assets/r2.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
