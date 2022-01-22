import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:old/oldhomeproject/url.dart';

class View {
  var GuardianName;
  var Relation;
  var ContactNo;
  var Address;
  var UserName;
  View({
    required this.GuardianName,
    required this.Relation,
    required this.Address,
    required this.UserName,
    required this.ContactNo,
  });

  factory View.fromMap(Map<String, dynamic> json) => View(
        GuardianName: json["GuardianName"],
        ContactNo: json["ContactNo"],
        Address: json["Address"],
        Relation: json["Relation"],
        UserName: json["UserName"],
      );
}

class OldHomeViewGuardianDetails extends StatefulWidget {
  int id;
  OldHomeViewGuardianDetails({Key? key, required this.id}) : super(key: key);

  @override
  _OldHomeViewGuardianDetailsState createState() =>
      _OldHomeViewGuardianDetailsState();
}

class _OldHomeViewGuardianDetailsState
    extends State<OldHomeViewGuardianDetails> {
  Future<List<View>> ViewGuardianuser() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/ViewGuardianInfo?id=${widget.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<View>((json) => View.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  late Future<List<View>> futureuser;
  @override
  void initState() {
    futureuser = ViewGuardianuser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardian Information'),
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
                                    snapshot.data![index].GuardianName
                                        .toString(),
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
                                    snapshot.data![index].Relation.toString(),
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
                                    snapshot.data![index].ContactNo.toString(),
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
                                    snapshot.data![index].Address.toString(),
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
      ),
    );
  }
}
