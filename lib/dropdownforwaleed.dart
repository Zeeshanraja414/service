import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:old/url.dart';

class Drop extends StatefulWidget {
  @override
  _DropState createState() => _DropState();
}

class _DropState extends State<Drop> {
  var mySelection = '';

  var url = "http://${IpAdress.ip}/OldHome1/api/oldhome/servicesname";

  List data = []; //edited line

  Future<String> getSWData() async {
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Management"),
      ),
      body: Center(
        child: DropdownButton(
          items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['Garden']),
              value: item['Room'].runtimeType,
            );
          }).toList(),
          onChanged: (dynamic newVal) {
            setState(() {
              mySelection = newVal;
            });
          },
          value: mySelection,
        ),
      ),
    );
  }
}
