import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Appointment extends StatefulWidget {
  const Appointment({
    Key? key,
  }) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  // DateTime SelectedDate = DateTime.now();
  TimeOfDay SelectedTime = TimeOfDay.now();
  String selectedgender = 'Male';
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController PhonenumController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  @override
  void initState() {
    super.initState();
    _time = TimeOfDay.now();
    _date = DateTime.now();
  }

  String url = "";
  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: _date, // Current Date
      firstDate: DateTime(2010), // First Date
      lastDate: DateTime(2050), // Last Date
      textDirection:
          TextDirection.ltr, // Header Text or Button Direction ltr or rtl
      initialDatePickerMode: DatePickerMode.day, // Day or Year Mode
      //   selectableDayPredicate: (DateTime val) =>
      //       val.weekday == 6 || val.weekday == 7 ? false : true, // WeekDay Off
      // selectableDayPredicate: (DateTime val) =>
      //     val.isBefore(val) ? false : true,
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        //SelectedDate = _date;
        print(
            //SelectedDate.toString(),
            _date);
      });
    }
  }

  Future<void> sendData() async {
    var res = await http.post(
      Uri.parse(url),
      body: {
        'Fname': FnameController.text,
        'Lname': LnameController.text,
        'Age': AgeController.text,
        'Gender': selectedgender,
        'Phone': PhonenumController.text,
        'Address': AddressController.text,
        // 'Service': widget.service,
        // 'Username': widget.username,
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: FnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: LnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: AgeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: PhonenumController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 330,
                    child: TextField(
                      controller: AddressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 40,
                    width: 50,
                    color: Colors.blueAccent,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender',
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                              ),
                            ),
                            Radio(
                              groupValue: selectedgender,
                              value: 'Male',
                              onChanged: (String? val) {
                                setState(() {
                                  selectedgender = val!;
                                  print(selectedgender);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Row(
                          children: [
                            Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                              ),
                            ),
                            Radio(
                              groupValue: selectedgender,
                              value: 'Female',
                              onChanged: (String? val) {
                                setState(() {
                                  selectedgender = val!;
                                  print(selectedgender);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextFormField(
            //     cursorColor: Color(0xFFC41A3B),
            //     readOnly: true,
            //     onTap: () {
            //       setState(() {
            //         _selectDate(context);
            //       });
            //     },
            //     decoration: InputDecoration(
            //         labelText: 'Select Date',
            //         // you can style labelText
            //         labelStyle: TextStyle(fontSize: 16.0),
            //         hintText: (_date.toString()),
            //         // you can style hintText
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //               color: Color(0xFFC41A3B),
            //               width:
            //                   2.0), // Focused Border you can style your own way
            //           // borderRadius: BorderRadius.circular(50.0), // Border Radius for outline
            //         ),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5.0), // Normal Border
            //         )),
            //   ),
            // ),

            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _pickTime();
                      });
                    },
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Text(
                          'Select Time',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.schedule,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Date: ',
                      style: TextStyle(fontSize: 20, color: Colors.teal),
                    ),
                    Text(
                      _date.day.toString() +
                          '-' +
                          _date.month.toString() +
                          '-' +
                          _date.year.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text(
                      'Time: ',
                      style: TextStyle(fontSize: 20, color: Colors.teal),
                    ),
                    Text('${_time.hour}:${_time.minute} '),
                  ],
                ),
              ),
            ),
            // ListTile(
            //   title: Text('Time : ${_time.hour}:${_time.minute}'),
            //   trailing: Icon(Icons.timer),
            //   onTap: _pickTime,
            // ),
            Container(
              height: 60,
              width: 200,
              padding: EdgeInsets.all(10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  sendData();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => hhcHome()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _pickTime() async {
    TimeOfDay? time = await showTimePicker(
        context: context,
        //initialTime: _time,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(),
            child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              ),
            ),
          );
        },
        initialTime: _time);
    if (time != null)
      setState(() {
        _time = time;
        SelectedTime = _time;
      });
    print(SelectedTime);
  }
}
