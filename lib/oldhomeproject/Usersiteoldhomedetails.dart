import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/UserSidepackagetype.dart';
import 'package:old/oldhomeproject/UserSideviewservicename.dart';
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

class OldHomeDetails extends StatefulWidget {
  final String oldhome;
  String FullName;
  int uid;
  OldHomeDetails(
      {Key? key,
      required this.oldhome,
      required this.FullName,
      required this.uid})
      : super(key: key);
  @override
  _OldHomeDetailsState createState() => _OldHomeDetailsState();
}

class _OldHomeDetailsState extends State<OldHomeDetails> {
  Future<List<Search>> searchOld() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/allsearched?name=${widget.oldhome}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Search>((json) => Search.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  TextEditingController IdController = TextEditingController();
  late bool error, sending, success;
  late String msg;

  late Future<List<Search>> futureSearch;
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    futureSearch = searchOld();
    super.initState();
  }

  var id;
  var OldhomeNAme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Old Home Details'),
        leading: BackButton(onPressed: () => Navigator.of(context).pop(true)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
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
                            id = snapshot.data![index].Id;
                            OldhomeNAme = snapshot.data![index].FullName;
                            return Column(
                              children: [
                                Text(
                                  'Old Home Name',
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
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'City',
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
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Gender',
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
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Contact No',
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
                                      snapshot.data![index].ContactNo
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Email',
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
                                      snapshot.data![index].Email.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Vacant Seats',
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
                                      snapshot.data![index].VacantSeats
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Total Seats',
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
                                      snapshot.data![index].TotalSeats
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 18,
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServiceNameUser(
                                    idsu: id,
                                  )));
                    },
                    child: Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PackageType(
                                    id: id,
                                    FullName: widget.FullName,
                                    uid: widget.uid,
                                    OldhomeName: OldhomeNAme,
                                  )));
                    },
                    child: Text(
                      'Packages',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
