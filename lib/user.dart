import 'package:flutter/material.dart';
class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List<String> items=<String>[
    'Islamabad',
    'Rawalpindi',
  ];
  List<String> item=<String>[
    'Male',
    'Female',
  ];

  String dropdownValue ='Rawalpindi';
  String Value='Male';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('User'),
          leading: BackButton(
              onPressed: () => Navigator.of(context).pop(true)
          ),
        ),
           body: SafeArea(
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   const SizedBox(height: 20,),
                   Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: DropdownButton<String>(
                       isExpanded: true,
                       onChanged: (String? newValue){
                         setState(() {
                           dropdownValue = newValue!;
                         });

                       },
                       value: dropdownValue,
                       items: items.map<DropdownMenuItem<String>>(
                             (String value){
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(value),
                           );
                         },
                       ).toList(),
                     ),
                   ),
                   const SizedBox(height: 30,),
                   const Padding(
                     padding: EdgeInsets.only(left: 15,right: 15),
                     child: TextField(
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         labelText: 'Search Old Home By Name',
                       ),
                     ),
                   ),
                   const SizedBox(height: 40,),
                   Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: DropdownButton<String>(
                       hint: const Text('Gender'),
                       isExpanded: true,
                       onChanged: (String? newValue){
                         setState(() {
                           Value = newValue!;
                         });

                       },
                       value: Value,
                       items: item.map<DropdownMenuItem<String>>(
                             (String value){
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(value),
                           );
                         },
                       ).toList(),
                     ),
                   ),
                   const SizedBox(height: 30,),
                   ElevatedButton(onPressed: (){}, child:const Text('Save'),),
                 ],
               ),
             ),
           ),
      ),
    );
  }
}
