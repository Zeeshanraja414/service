import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/url.dart';

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

class ViewRequest extends StatefulWidget {
  int id;
  ViewRequest({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ViewRequestState createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  late bool error, sending, success;
  late String msg;

  Future<void> Accept() async {
    var res = await http.patch(
        Uri.parse(
            ('http://${IpAdress.ip}/OldHome1/api/oldhome/Acceptstatus?id=${uid}&p=${pid}&o=${ohid}')),
        body: {
          'Status': 'Accepted',
        });

    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        setState(() {
          sending = false;
          success = true;
        });
      }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  Future<void> decrement() async {
    var res = await http.patch(
        Uri.parse(
            ('http://${IpAdress.ip}/OldHome1/api/oldhome/DecrmentVacantSeat?id=${widget.id}')),
        body: {
          'VacantSeats': '',
        });

    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        setState(() {
          sending = false;
          success = true;
        });
      }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  Future<void> Reject() async {
    var res = await http.patch(
        Uri.parse(
            ('http://${IpAdress.ip}/OldHome1/api/oldhome/Rejectstatus?id=${uid}&p=${pid}&o=${ohid}')),
        body: {
          'Status': 'Accepted',
        });
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        setState(() {
          sending = false;
          success = true;
        });
      }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  late Future<List<Post>> futurePost;

  Future<List<Post>> getRequest() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/ViewRequest?id=${widget.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((json) => Post.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  bool visible = true;
  @override
  void initState() {
    super.initState();
    error = false;
    sending = false;
    success = false;
    futurePost = getRequest();
  }

  var ohid;
  var uid;
  var pid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Requests'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              FutureBuilder<List<Post>>(
                future: futurePost,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          ohid = snapshot.data![index].OHId;
                          pid = snapshot.data![index].Pid;
                          uid = snapshot.data![index].Id;
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 35, 0, 0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 70, 0, 0),
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
                                      const EdgeInsets.fromLTRB(90, 175, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      decrement();
                                      setState(() {
                                        Accept();
                                        Navigator.of(context).pop();
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             super.widget));
                                      });
                                    },
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(200, 175, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Reject();
                                      setState(() {
                                        //Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    super.widget));
                                      });
                                    },
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
