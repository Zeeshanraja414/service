import 'package:flutter/material.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:Scaffold(
        appBar: AppBar(title: Text('Packages'),
          leading: BackButton(
              onPressed: () => Navigator.of(context).pop(true)
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
             children: [
              const SizedBox(height:20),
               Container(
                 padding: const EdgeInsets.all(10),
                 child: const TextField(
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     labelText: 'Package 1',
                   ),
                 ),
               ),
               const SizedBox(height:20),
               Container(
                 padding: const EdgeInsets.all(10),
                 child: const TextField(
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     labelText: 'Package 2',
                   ),
                 ),
               ),
               const SizedBox(height:20),
               Container(
                 padding: const EdgeInsets.all(10),
                 child: const TextField(
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     labelText: 'Package 3',
                   ),
                 ),
               ),
             ],
            ),
          ),
        ),
      )
    );
  }
}
