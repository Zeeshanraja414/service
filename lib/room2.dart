import 'package:flutter/material.dart';

class Room2 extends StatefulWidget {
  const Room2({Key? key}) : super(key: key);

  @override
  _Room2State createState() => _Room2State();
}

class _Room2State extends State<Room2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              width: 500,
              child: Image.asset('assets/libra.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 400,
              //width: 400,
              child: Image.asset('assets/libra2.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 200,
              width: 400,
              child: Image.asset('assets/libra3.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
