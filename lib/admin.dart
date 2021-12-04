import 'package:flutter/material.dart';
import 'package:old/adddetail.dart';
import 'package:old/addservices.dart';
import 'package:old/multiimagepicker.dart';
import 'package:old/setpolicy.dart';
import 'package:old/viewpolicy.dart';
import 'package:old/viewserices.dart';

import 'adddetails.dart';


class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin'),),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 70.0,
              ),
              Container(
                  height: 100,
                  width: 400,
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
                      'Add Details',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Details()));
                    },
                  )),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                  height: 100,
                  width: 400,
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
                      'Add Services',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Multiimage() ));
                    },
                  )),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                  height: 100,
                  width: 400,
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
                      'View Services',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage() ));
                    },
                  )),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                height: 100,
                width: 400,
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
                    'Set Packages',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Policy()));
                  },
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                  height: 100,
                  width: 400,
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
                      'View Packages',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const View()));
                    },
                  )),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                height: 100,
                width: 400,
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
                    'View Request',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Multiimage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
