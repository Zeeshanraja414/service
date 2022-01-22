import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:old/oldhomeproject/url.dart';

class View {
  int Pid;
  var RelativeName;
  var Relation;
  var Gender;
  View({
    required this.Pid,
    required this.RelativeName,
    required this.Relation,
    required this.Gender,
  });

  factory View.fromMap(Map<String, dynamic> json) => View(
        Pid: json["Pid"],
        RelativeName: json["RelativeName"],
        Gender: json["Gender"],
        Relation: json["Relation"],
      );
}

class BookforotherDetails extends StatefulWidget {
  int id;
  int ohid;
  int pid;
  BookforotherDetails(
      {Key? key, required this.id, required this.ohid, required this.pid})
      : super(key: key);

  @override
  _BookforotherDetailsState createState() => _BookforotherDetailsState();
}

class _BookforotherDetailsState extends State<BookforotherDetails> {
  Future<List<View>> ViewGuardianuser() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/BookforOtherdetails?id=${widget.id}&ohid=${widget.ohid}&pid=${widget.pid}'));
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<View>((json) => View.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  var p;
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
                            p = snapshot.data![index].Pid;
                            return Column(children: [
                              Text(
                                'Relative Name',
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
                                    snapshot.data![index].RelativeName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Relation',
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
