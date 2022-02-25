import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:old/oldhomeproject/url.dart';
import 'package:old/Searchbydate.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

List<Location> locationFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  Location(
      {required this.Pid,
      required this.BookingType,
      required this.PackageName,
      required this.PackageDetails,
      required this.Duration,
      required this.TotalPrice,
      required this.StayDuration,
      required this.OldhomeName,
      required this.Date});

  var Pid;
  var BookingType;
  var PackageName;
  var PackageDetails;
  var Duration;
  var TotalPrice;
  var StayDuration;
  var OldhomeName;
  var Date;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        Pid: json["Pid"],
        BookingType: json["BookingType"],
        PackageName: json["PackageName"],
        PackageDetails: json["PackageDetails"],
        Duration: json["Duration"],
        TotalPrice: json["TotalPrice"],
        StayDuration: json["StayDuration"],
        OldhomeName: json["OldhomeName"],
        Date: json["Date"],
      );

  Map<String, dynamic> toJson() => {
        Pid: ["Pid"],
        BookingType: ["BookingType"],
        PackageName: ["PackageName"],
        PackageDetails: ["PackageDetails"],
        Duration: ["Duration"],
        TotalPrice: ["TotalPrice"],
        StayDuration: ["StayDuration"],
        OldhomeName: ["OldhomeName"],
        Date: ["Date"],
      };
}

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

class Room2 extends StatefulWidget {
  const Room2({Key? key}) : super(key: key);

  @override
  _Room2State createState() => _Room2State();
}

Object? _value = 'Male';

class _Room2State extends State<Room2> {
  TextEditingController Pass = TextEditingController();
  List<Location> m = [];
  Future<List<Location>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/PackageSearch?type=${_value}&Id=${Pass.text}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      List<Location> obj = locationFromJson(response.body);
      setState(() {
        m.addAll(obj);
      });
      return obj;
    } else {
      throw ('');
    }
  }

  double rating = 0;
  Future<List<Search>> ratingsearch() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/searchrate?rating=${rating}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Search>((json) => Search.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  // late Future<List<Search>> futureSearch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ratingsearch();
    //fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SmoothStarRating(
                //rating: 5,
                starCount: 5,
                isReadOnly: false,
                size: 50,
                spacing: 3,
                allowHalfRating: true,
                onRated: (value) {
                  setState(() {
                    rating = value;
                  });
                }),
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
                    }),
                const Text(
                  'Book For Other',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Radio(
                  value: 'BookforYourself',
                  activeColor: Colors.blue,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                const Text(
                  'Book',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: Pass,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pass',
              ),
              style: TextStyle(),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     fetchPost();
            //   },
            //   child: Text('press'),
            //   // Text(m.addAll(Pass));
            // ),
            FutureBuilder<List<Search>>(
                future: ratingsearch(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          return Column(children: [
                            Text(
                              'Guardian Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Card(
                              child: Container(
                                height: 40,
                                width: 350,
                                padding: EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                )),
                                child: Text(
                                  snapshot.data![index].FullName.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Relation with Guardian',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Card(
                              child: Container(
                                height: 40,
                                width: 350,
                                padding: EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                )),
                                child: Text(
                                  snapshot.data![index].Gender.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Contact No of Guardian',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Card(
                              child: Container(
                                height: 40,
                                width: 350,
                                padding: EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                )),
                                child: Text(
                                  snapshot.data![index].Rating.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Guardian Address',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Card(
                              child: Container(
                                height: 40,
                                width: 350,
                                padding: EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                )),
                                child: Text(
                                  snapshot.data![index].City.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ]);
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
