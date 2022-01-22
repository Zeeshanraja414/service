import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:old/oldhomeproject/UserSideAddGuardianDetails.dart';
import 'package:old/oldhomeproject/UserSideViewGuardianDetail.dart';
import 'package:old/oldhomeproject/UserSideviewrequest.dart';
import 'package:old/oldhomeproject/Usersiteoldhomedetails.dart';
import 'package:old/oldhomeproject/UserSideseeoldhomename.dart';
import 'package:old/oldhomeproject/url.dart';

class Search {
  Search({
    required this.Id,
    required this.FullName,
    required this.ContactNo,
    required this.Address,
    required this.City,
    required this.UserName,
    required this.Email,
    required this.TotalSeats,
    required this.VacantSeats,
    required this.Gender,
  });
  var Id;
  var UserName;
  var FullName;
  var ContactNo;
  var Address;
  var City;
  var Email;
  var TotalSeats;
  var VacantSeats;
  var Gender;

  factory Search.fromMap(Map<String, dynamic> json) => Search(
        Id: json["Id"],
        UserName: json["UserName"],
        FullName: json["FullName"],
        ContactNo: json["ContactNo"],
        Address: json["Address"],
        City: json["City"],
        Email: json["Email"],
        TotalSeats: json["TotalSeats"],
        VacantSeats: json["VacantSeats"],
        Gender: json["Gender"],
      );
}

class View {
  var Status;
  var OldhomeName;
  var PackageName;
  var BookingType;
  var Date;
  View({
    required this.Status,
    required this.OldhomeName,
    required this.BookingType,
    required this.PackageName,
    required this.Date,
  });

  factory View.fromMap(Map<String, dynamic> json) => View(
        Status: json["Status"],
        OldhomeName: json["OldhomeName"],
        PackageName: json["PackageName"],
        BookingType: json["BookingType"],
        Date: json["Date"],
      );
}

class User extends StatefulWidget {
  String Fullname;
  int uid;
  User({Key? key, required this.Fullname, required this.uid}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  TextEditingController FullNameController = TextEditingController();
  Object? _value = '';
  Future<List<Search>> searchOld() async {
    final response = await http.get(
        Uri.parse('http://${IpAdress.ip}/OldHome1/api/oldhome/allsearches'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Search>((json) => Search.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<View>> ViewRequestuser() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/Viewrequestuser?id=${widget.uid}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<View>((json) => View.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  var FullName;
  var City;
  var Gender;
  late Future<List<Search>> futureSearch;
  late Future<List<View>> futureuser;
  @override
  void initState() {
    futureSearch = searchOld();
    futureuser = ViewRequestuser();
    super.initState();
  }

  Future<void> refresh() async {
    setState(() {
      futureuser = ViewRequestuser();
    });
  }

  List<String> items = <String>['Islamabad', 'Rawalpindi', 'Karachi'];

  var dropdownValue = 'Rawalpindi';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('View or Search Old Home'),
          //leading: BackButton(onPressed: () => Navigator.of(context).pop(true)),
        ),
        drawer: RefreshIndicator(
          onRefresh: refresh,
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuardianInfo(
                                        id: widget.uid,
                                        name: widget.Fullname,
                                      )));
                        },
                        child: Text(
                          'Add Guardian Details',
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserViewGuardianDetails(
                                        id: widget.uid,
                                      )));
                        },
                        child: Text(
                          'View Guardian Details',
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserViewRequest(
                                      id: widget.uid,
                                    )));
                      },
                      child: Text(
                        'View Requests',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 230,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      autofocus: true,
                      focusColor: Colors.white,
                      hint: const Text(
                        'Select City',
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
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: FullNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search Old Home By Name',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Radio(
                          value: 'Male',
                          activeColor: Colors.blue,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                      const Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Radio(
                        value: 'Female',
                        activeColor: Colors.blue,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                      const Text(
                        'FeMale',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    FullName = FullNameController.text;
                    City = dropdownValue;
                    Gender = _value;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OldHomeName(
                                  Name: FullName,
                                  City: City,
                                  Gender: Gender,
                                  Fullname: widget.Fullname,
                                  uid: widget.uid,
                                )));
                  },
                  child: const Text('Search'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    'ALL OLD HOME NAMES',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                FutureBuilder<List<Search>>(
                    future: futureSearch,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: TextButton(
                                      onPressed: () {
                                        var ss = snapshot.data![index].FullName;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OldHomeDetails(
                                                      oldhome: ss,
                                                      FullName: widget.Fullname,
                                                      uid: widget.uid,
                                                    )));
                                      },
                                      child: Text(
                                        snapshot.data![index].FullName
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(child: Text('${snapshot.error}'));
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
