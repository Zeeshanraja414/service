import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/url.dart';

class Package extends StatefulWidget {
  int id;
  Package({Key? key, required this.id}) : super(key: key);

  @override
  _PackageState createState() => _PackageState();
}

class _PackageState extends State<Package> {
  TextEditingController PackageNameController = TextEditingController();
  TextEditingController TotalPriceController = TextEditingController();
  TextEditingController DurationController = TextEditingController();
  TextEditingController InstallmentController = TextEditingController();
  TextEditingController BookingTypeController = TextEditingController();
  TextEditingController PackageDetailsController = TextEditingController();
  TextEditingController StayDurationController = TextEditingController();
  TextEditingController IdController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void validate() {
    if (_formkey.currentState!.validate()) {
      print('ok');
    }
  }

  Object? _value = 'BookforYourself';
  late bool error, sending, success;
  late String msg;
  String url = "http://${IpAdress.ip}/OldHome1/api/oldhome/addpackage";
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  Future<void> sendPackage() async {
    var res = await http.post(Uri.parse(url), body: {
      'BookingType': _value.toString(),
      'PackageName': PackageNameController.text,
      'PackageDetails': PackageDetailsController.text,
      'Duration': DurationController.text,
      'TotalPrice': TotalPriceController.text,
      'Installment': InstallmentController.text,
      'StayDuration': StayDurationController.text,
      'Id': widget.id.toString(),
    });
    if (res.statusCode == 200) {
      //print(res.body);
      print(widget.id);
      var data = json.decode(res.body);
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        _value = '';
        PackageNameController.text = '';
        PackageDetailsController.text = '';
        DurationController.text = '';
        TotalPriceController.text = '';
        InstallmentController.text = '';
        StayDurationController.text = '';
        widget.id = '' as int;

        setState(() {
          sending = false;
          success = true;
        });
      }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Packages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(right: 50.0),
                  child: Text(
                    'Booking Type',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Radio(
                        value: 'BookforYourself',
                        activeColor: Colors.blue,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        }),
                    const Text(
                      'Book For Yourself',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Row(
                  children: [
                    Radio(
                      value: 'BookforOther',
                      activeColor: Colors.blue,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                    const Text(
                      'Book For Other',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: PackageNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Package Name',
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
                  child: TextFormField(
                    controller: TotalPriceController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price',
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
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: DurationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Duration',
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
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: StayDurationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Stay Duration',
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
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: PackageDetailsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Details',
                    ),
                    minLines: 1,
                    maxLines: 15,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                        sendPackage();
                        print('successfull');
                      } else {
                        print('unsuccessfull');
                      }
                      // Navigator.push(context,
                      //MaterialPageRoute(builder: (context) => const LoginPage()));
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
