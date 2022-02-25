import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:old/Models/Locations.dart';
import 'package:old/Models/Rating.dart';
import 'package:old/Models/Rating.dart';
import 'package:old/Models/Rating.dart';
import 'package:old/oldhomeproject/UserSideAddGuardianDetails.dart';
import 'package:old/oldhomeproject/UserSideSearchbycost.dart';
import 'package:old/oldhomeproject/UserSideViewGuardianDetail.dart';
import 'package:old/oldhomeproject/UserSidesearchbyrating.dart';
import 'package:old/oldhomeproject/UserSideviewrequest.dart';
import 'package:old/oldhomeproject/Usersiteoldhomedetails.dart';
import 'package:old/oldhomeproject/UserSideseeoldhomename.dart';
import 'package:old/oldhomeproject/login.dart';
import 'package:old/oldhomeproject/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'UserSidegiverating.dart';

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
    required this.Rating,
  });
  var Rating;
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
        Rating: json["Rating"],
      );
}

class View {
  var OHId;
  var Status;
  var OldhomeName;
  var PackageName;
  var BookingType;
  var Date;
  View({
    required this.OHId,
    required this.Status,
    required this.OldhomeName,
    required this.BookingType,
    required this.PackageName,
    required this.Date,
  });

  factory View.fromMap(Map<String, dynamic> json) => View(
        OHId: json["OHId"],
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

  List<Location> items = [];

  String dropdownValue = 'Rawalpindi';

  Future<List<Location>> CityDropDown() async {
    final response = await http
        .get(Uri.parse('http://${IpAdress.ip}/OldHome1/api/oldhome/citydrop'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      List<Location> obj = locationFromJson(response.body);
      setState(() {
        items.addAll(obj);
      });
      for (int i = 0; i < obj.length; i++) {
        s.add(obj[i].id);
      }
      return obj;
    } else {
      throw Exception('Failed');
    }
  }

  List s = [];
  Future<List<Star>> viewRating() async {
    final response = await http
        .get(Uri.parse('http://${IpAdress.ip}/OldHome1/api/oldhome/rate'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      List<Star> rbj = starFromJson(response.body);
      setState(() {
        rate.addAll(rbj);
      });
      return rbj;
    } else {
      throw Exception('Failed');
    }
  }

  List<Star> rate = [];
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
  late Future<List<Star>> futurestar;

  @override
  void initState() {
    //viewRating();
    CityDropDown();
    futureSearch = searchOld();
    futureuser = ViewRequestuser();
    futurestar = viewRating();
    super.initState();
  }

  Future<void> refresh() async {
    setState(() {
      futureuser = ViewRequestuser();
    });
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('View or Search Old Home'),
          actions: const [],
          //leading: BackButton(onPressed: () => Navigator.of(context).pop(true)),
        ),
        drawer: RefreshIndicator(
          onRefresh: refresh,
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 320,
                    color: Colors.blue[300],
                    child: Center(
                      child: Text(
                        widget.Fullname,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.forward,
                        color: Colors.blue,
                      ),
                      Container(
                        key: UniqueKey(),
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
                              // '\u2022'
                              ' Add Guardian Details',
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.forward,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserViewGuardianDetails(
                                            id: widget.uid,
                                          )));
                            },
                            child: Text(
                              'View Guardian Details',
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.forward,
                        color: Colors.blue,
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                      Container(
                        key: UniqueKey(),
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              logoutUser();
                            },
                            child: Text(
                              // '\u2022'
                              ' Logout',
                            )),
                      ),
                    ],
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
                  padding: const EdgeInsets.only(left: 40),
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
                        'Female',
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
                Container(
                  width: 200,
                  child: ElevatedButton(
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
                    child: const Text(
                      'Search',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: DropdownButton(
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
                    items: items.map((item) {
                      return DropdownMenuItem(
                        child: new Text(item.city),
                        value: item.city,
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                  ),
                ),
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
                              builder: (context) => SearchbyCost(
                                    drop: dropdownValue,
                                    User: widget.Fullname,
                                    uid: widget.uid,
                                  )));
                    },
                    child: Text(
                      "Search By Cost",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchbyRanking(
                                      drop: dropdownValue,
                                      User: widget.Fullname,
                                      uid: widget.uid,
                                    )));
                      },
                      child: Text(
                        "Search By Ranking",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
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
                SizedBox(
                  height: 20,
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
                              return Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    //color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 4,
                                    )),
                                child: TextButton(
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
                                  child: Stack(
                                    children: <Widget>[
                                      Text(
                                        'Old Home Name  :',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 170),
                                        child: Text(
                                          snapshot.data![index].FullName,
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 35, 0, 0),
                                        child: Text(
                                          'City                         :',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            170, 35, 0, 0),
                                        child: Text(
                                          snapshot.data![index].City,
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 70, 0, 0),
                                        child: Text(
                                          'Gender                   :',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            170, 70, 0, 0),
                                        child: Text(
                                          snapshot.data![index].Gender,
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.fromLTRB(
                                      //       0, 105, 0, 0),
                                      //   child: Text(
                                      //     'Cost                        :',
                                      //     style: TextStyle(
                                      //       color: Colors.blue,
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 20,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                              //   ListTile(
                              //   title: TextButton(
                              //     onPressed: () {
                              //       var ss = snapshot.data![index].FullName;
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   OldHomeDetails(
                              //                     oldhome: ss,
                              //                     FullName: widget.Fullname,
                              //                     uid: widget.uid,
                              //                   )));
                              //     },
                              //     child: Text(
                              //       snapshot.data![index].FullName,
                              //       style: TextStyle(
                              //         fontSize: 20,
                              //       ),
                              //     ),
                              //   ),
                              //   subtitle: Center(
                              //     child: SmoothStarRating(
                              //       rating: snapshot.data![index].Rating,
                              //       starCount: 5,
                              //       isReadOnly: true,
                              //       size: 25,
                              //       spacing: 3,
                              //       allowHalfRating: true,
                              //     ),
                              //   ),
                              // );
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
