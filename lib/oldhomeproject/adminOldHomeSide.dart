import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:old/oldhomeproject/ViewHistoryOldHomeSide.dart';
import 'package:old/oldhomeproject/packagesnameOldHomeSide.dart';
import 'package:old/oldhomeproject/ViewRequestOldHomeSide.dart';
import 'package:old/oldhomeproject/url.dart';
import 'package:old/oldhomeproject/viewsericesnameOldHomeSide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adddetailOldHomeSide.dart';
import 'login.dart';

class Post {
  Post({
    required this.Id,
    required this.FullName,
    required this.Pid,
    required this.PackageName,
    required this.Status,
    required this.OHId,
  });
  var Id;
  var FullName;
  var Pid;
  var PackageName;
  var Status;
  var OHId;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        Id: json["Id"],
        FullName: json["FullName"],
        Pid: json["Pid"],
        PackageName: json["PackageName"],
        Status: json["Status"],
        OHId: json["OHId"],
      );
}

class Admin extends StatefulWidget {
  final int id;
  final int idp;
  final int ids;
  Admin({
    Key? key,
    required this.id,
    required this.idp,
    required this.ids,
  }) : super(key: key);
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int c = 0;
  Future countRequest() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/Countnotification?id=${widget.id}'));
    if (response.statusCode == 200) {
      //print(response.body);
      setState(() {
        c = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed');
    }
    return countRequest();
  }

  @override
  void initState() {
    super.initState();
    countRequest();
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADMIN'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  logoutUser();
                },
                icon: Icon(Icons.logout),
                iconSize: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text('Logout'),
              ),
            ],
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                    height: 100,
                    width: 400,
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detail(id: widget.id)));
                      },
                    )),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                    height: 100,
                    width: 400,
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Services',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesName(
                                      id: widget.ids,
                                    )));
                      },
                    )),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                    height: 100,
                    width: 400,
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Packages',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => View(
                                      id: widget.idp,
                                    )));
                      },
                    )),
                const SizedBox(
                  height: 25.0,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 400,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          child: Badge(
                            position: BadgePosition.topEnd(top: -18),
                            badgeColor: Colors.white,
                            badgeContent: Text(
                              '$c',
                              style: TextStyle(fontSize: 15),
                            ),
                            child: Text(
                              'View Request',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewRequest(
                                          id: widget.id,
                                        )));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                    height: 100,
                    width: 400,
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Request History',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewHistory(
                                      id: widget.id,
                                    )));
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
