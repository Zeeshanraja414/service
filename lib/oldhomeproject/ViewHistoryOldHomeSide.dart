import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:old/oldhomeproject/ViewBookingforotherdetailsOLDHOMESIDE.dart';
import 'package:old/oldhomeproject/ViewGuardianDetailsOldHomeSide.dart';
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

  var uid;
  bool isVisible = false;
  bool Visible = true;
  late Future<List<Post>> futurePost;
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   isVisible=!isVisible;
    // });
    futurePost = fetchPost();
  }

  var ohid;
  var pid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Requests History'),
          centerTitle: true,
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
                        return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              // snapshot.data![index].Status == 'Accepted'
                              //     ? Colors.green
                              //     : snapshot.data![index].Status == 'Rejected'
                              //         ? Colors.red
                              //         : Colors.grey[200],
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
                                    // color: snapshot.data![index].Status ==
                                    //         'Pending'
                                    //     ? Colors.green
                                    //     : Colors.red,
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
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 170, 0, 0),
                                  child: Visibility(
                                    visible: snapshot.data![index].Status ==
                                            'Accepted'
                                        ? Visible
                                        : isVisible,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        uid = snapshot.data![index].Id;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OldHomeViewGuardianDetails(
                                                      id: uid,
                                                    )));
                                      },
                                      child: Text('View Guardian Information'),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 210, 0, 0),
                                  child: Visibility(
                                    visible: snapshot.data![index].Status ==
                                            'Accepted'
                                        ? snapshot.data![index].BookingType ==
                                                'BookforOther'
                                            ? Visible
                                            : isVisible
                                        : isVisible,
                                    child: Container(
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          uid = snapshot.data![index].Id;
                                          ohid = snapshot.data![index].OHId;
                                          pid = snapshot.data![index].Pid;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookforotherDetails(
                                                        id: uid,
                                                        ohid: ohid,
                                                        pid: pid,
                                                      )));
                                        },
                                        child: Text('Other Details'),
                                      ),
                                    ),
                                  )),
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
