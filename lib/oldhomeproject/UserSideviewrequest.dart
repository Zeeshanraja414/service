import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:old/oldhomeproject/UserSidegiverating.dart';
import 'package:old/oldhomeproject/url.dart';

class View {
  int Id;
  int OHId;
  var Status;
  var OldhomeName;
  var PackageName;
  var BookingType;
  var Date;
  View({
    required this.OHId,
    required this.Id,
    required this.Status,
    required this.OldhomeName,
    required this.BookingType,
    required this.PackageName,
    required this.Date,
  });

  factory View.fromMap(Map<String, dynamic> json) => View(
        OHId: json["OHId"],
        Id: json["Id"],
        Status: json["Status"],
        OldhomeName: json["OldhomeName"],
        PackageName: json["PackageName"],
        BookingType: json["BookingType"],
        Date: json["Date"],
      );
}

class UserViewRequest extends StatefulWidget {
  int id;
  UserViewRequest({Key? key, required this.id}) : super(key: key);

  @override
  _UserViewRequestState createState() => _UserViewRequestState();
}

class _UserViewRequestState extends State<UserViewRequest> {
  Future<List<View>> ViewRequestuser() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/Viewrequestuser?id=${widget.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<View>((json) => View.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  late Future<List<View>> futureuser;
  bool isnotVisible = false;
  bool Visible = true;
  @override
  void initState() {
    futureuser = ViewRequestuser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Request'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<View>>(
                  future: futureuser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 4,
                                  )),
                              child: Stack(
                                children: <Widget>[
                                  Text(
                                    'Old Home Name   :',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 150),
                                    child: Text(
                                      snapshot.data![index].OldhomeName,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                    child: Text(
                                      'Selected Package :',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        160, 35, 0, 0),
                                    child: Text(
                                      snapshot.data![index].PackageName,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 70, 0, 0),
                                    child: Text(
                                      'Booking Type         :',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        160, 70, 0, 0),
                                    child: Text(
                                      snapshot.data![index].BookingType,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 105, 0, 0),
                                    child: Text(
                                      'Date                         :',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        160, 105, 0, 0),
                                    child: Text(
                                      snapshot.data![index].Date,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 140, 0, 0),
                                    child: Text(
                                      'Status                      :',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        160, 140, 0, 0),
                                    child: Text(
                                      snapshot.data![index].Status,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: snapshot.data![index].Status ==
                                            'Accepted'
                                        ? Visible
                                        : isnotVisible,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          140, 175, 0, 0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Rating(
                                                        uid: widget.id,
                                                        ohid: snapshot
                                                            .data![index].OHId,
                                                      )));
                                        },
                                        child: Text('Give Rating'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}
