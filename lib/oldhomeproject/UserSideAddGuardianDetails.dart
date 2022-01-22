import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/url.dart';

class GuardianInfo extends StatefulWidget {
  int id;
  String name;
  GuardianInfo({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _GuardianInfoState createState() => _GuardianInfoState();
}

class _GuardianInfoState extends State<GuardianInfo> {
  TextEditingController GuardianName = TextEditingController();
  TextEditingController GuardianContact = TextEditingController();
  TextEditingController Relation = TextEditingController();
  TextEditingController GuardianAddress = TextEditingController();
  TextEditingController GuardianCnic = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  List<String> items = <String>[
    'Son',
    'Daughter',
    'Husband',
    'Wife',
    'Brother',
    'Sister',
    'GrandSon',
    'GrandDaughter',
    'Uncle',
    'Aunt',
    'Nephew',
    'Niece',
    'Cousin'
  ];

  var dropdownValue = 'Son';
  late bool error, sending, success;
  late String msg;
  String url = "http://${IpAdress.ip}/OldHome1/api/oldhome/GuardianInfo";
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(url), body: {
      'GuardianName': GuardianName.text,
      'Relation': dropdownValue,
      'ContactNo': GuardianContact.text,
      'Address': GuardianAddress.text,
      'Cnic': GuardianCnic.text,
      'UserName': widget.name,
      'Id': widget.id.toString(),
    });
    if (res.statusCode == 200) {
      print(res.body);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Guardian Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: GuardianName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Guardian Name',
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    autofocus: true,
                    focusColor: Colors.white,
                    hint: const Text(
                      'Relation With Guardian',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.teal,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    value: dropdownValue,
                    items: items.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    dropdownColor: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: GuardianContact,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Guardian Contact Number',
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(10),
                //   child: TextFormField(
                //     keyboardType: TextInputType.emailAddress,
                //     controller: GuardianCnic,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Guardian CNIC',
                //     ),
                //     validator: (val) {
                //       if (val!.isEmpty) {
                //         return 'Required';
                //       } else {
                //         return null;
                //       }
                //     },
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: GuardianAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Guardian Address',
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  height: 60,
                  width: 200,
                  padding: const EdgeInsets.all(10),
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
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      validate;
                      setState(() {
                        sending = true;
                      });
                      if (_formkey.currentState!.validate()) {
                        sendData();
                        print('successfull');
                      } else {
                        print('unsuccessfull');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
