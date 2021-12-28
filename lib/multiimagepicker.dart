import 'package:flutter/material.dart';

class Show extends StatefulWidget {
  const Show({Key? key}) : super(key: key);

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 200,
                width: 350,
                child:Image.asset('assets/gard1.jpg',
                  fit: BoxFit.fitWidth,),
            ),
            Container(
              height: 400,
              width: 1500,
              child:Image.asset('assets/gard2.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 300,
              width: 1000,
              child:Image.asset('assets/gard3.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
