import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:old/oldhomeproject/url.dart';
import 'package:intl/intl.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    required this.Id,
    required this.FullName,
    required this.Pid,
    required this.PackageName,
    required this.Status,
    required this.OHId,
    required this.BookingType,
    required this.Date,
  });
  var Id;
  var FullName;
  var Pid;
  var PackageName;
  var Status;
  var OHId;
  var BookingType;
  var Date;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        Id: json["Id"],
        FullName: json["FullName"],
        Pid: json["Pid"],
        PackageName: json["PackageName"],
        Status: json["Status"],
        OHId: json["OHId"],
        BookingType: json["BookingType"],
        Date: json["Date"],
      );
}

class ViewHistory extends StatefulWidget {
  int id;
  ViewHistory({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/viewhistory?id=${widget.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((json) => Post.fromMap(json)).toList();
    } else {
      print(ohid);
      throw Exception('Failed');
    }
  }

  late Future<List<Post>> futurePost;
  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  var ohid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Package Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Post>>(
                future: futurePost,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        ohid = snapshot.data![index].OHId;
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
                                'User FullName       :',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: Text(
                                  snapshot.data![index].FullName,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                child: Text(
                                  'Selected Package :',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(200, 35, 0, 0),
                                child: Text(
                                  snapshot.data![index].PackageName,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                                child: Text(
                                  'Booking Type         :',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(200, 70, 0, 0),
                                child: Text(
                                  snapshot.data![index].BookingType,
                                  style: TextStyle(
                                    fontSize: 20,
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
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(200, 105, 0, 0),
                                child: Text(
                                  snapshot.data![index].Date,
                                  style: TextStyle(
                                    fontSize: 20,
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
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(200, 140, 0, 0),
                                child: Text(
                                  snapshot.data![index].Status,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
