import 'package:flutter/material.dart';

class Table11 extends StatefulWidget {
  const Table11({Key? key}) : super(key: key);

  @override
  _Table11State createState() => _Table11State();
}

class _Table11State extends State<Table11> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            0: FixedColumnWidth(150.0), // fixed to 100 width
            // 1: FlexColumnWidth(),
            // 2: FixedColumnWidth(50.0), //fixed to 100 width
          },
          children: [
            TableRow(children: [
              Text('Reg NO \n'
                  'Name'),
              Text('06-10'),
              Text('06-10'),
              Text('06-10'),
              Text('06-10'),
              Text('06-10'),
              Text('06-10'),
              Text('06-10'),
            ]),
            TableRow(children: [
              Text('2018-Arid-0100 Muhammad Abdullah'),
              Center(child: Text('P')),
              Center(child: Text('P')),
              Center(child: Text('A')),
              Center(child: Text('P')),
              Center(child: Text('P')),
              Center(child: Text('A')),
              Center(child: Text('P')),
            ]),
          ],
        ),
      ),
    );
  }
}
