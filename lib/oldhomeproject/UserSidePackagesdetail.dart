import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:old/oldhomeproject/url.dart';
import 'package:intl/intl.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post(
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

  factory Post.fromMap(Map<String, dynamic> json) => Post(
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
}

class PackagedetailUser extends StatefulWidget {
  final String name;
  int OHid;
  String FullNAme;
  int uid;
  String OldhomeName;
  PackagedetailUser({
    Key? key,
    required this.name,
    required this.OHid,
    required this.FullNAme,
    required this.uid,
    required this.OldhomeName,
  }) : super(key: key);
  @override
  _PackagedetailUserState createState() => _PackagedetailUserState();
}

class _PackagedetailUserState extends State<PackagedetailUser> {
  showAlertDialog(BuildContext context) {
    // set up the button
    // TextButton(
    //   child: Text("Ok"),
    //   onPressed: () {
    //     Navigator.of(context).pop;
    //   },
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Request Send Successfully"),
      //content: Text(""),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  late bool error, sending, success;
  late String msg;
  var Pid;
  var PackageName;
  var b;
  String url = "http://${IpAdress.ip}/OldHome1/api/oldhome/Sendrequestpost";

  Future<void> Request() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    var res = await http.post(Uri.parse(url), body: {
      'FullName': widget.FullNAme,
      'PackageName': PackageName,
      'Status': 'Pending',
      'Id': widget.uid.toString(),
      'Pid': Pid.toString(),
      'OHId': widget.OHid.toString(),
      'OldhomeName': widget.OldhomeName,
      'BookingType': b,
      'Date': formattedDate,
      'RelativeName': RelativeName.text,
      'Relation': dropdownValue,
      'Gender': _value,
    });
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
    }
  }

  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/packagedetails?name=${widget.name}&Id=${widget.OHid}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((json) => Post.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  TextEditingController RelativeName = TextEditingController();
  TextEditingController Relation = TextEditingController();
  late Future<List<Post>> futurePost;
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
    futurePost = fetchPost();
  }

  List<String> items = <String>[
    'Son',
    'Daughter',
    'Husband',
    'Wife',
    'Brother',
    'Sister',
    'GrandSon',
    'GrandDaughter',
    'Uncle',
    'Aunt',
    'Nephew',
    'Niece',
    'Cousin'
  ];

  var dropdownValue = 'Son';
  Object? _value = '';

  bool notVisibe = false;
  bool Visible = true;
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
                        Pid = snapshot.data![index].Pid;
                        PackageName = snapshot.data![index].PackageName;
                        b = snapshot.data![index].BookingType;
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Visibility(
                                visible: snapshot.data![index].BookingType ==
                                        'BookforOther'
                                    ? Visible
                                    : notVisibe,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Add Relative Detail',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFormField(
                                          controller: RelativeName,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Relative Name',
                                          ),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          autofocus: true,
                                          focusColor: Colors.white,
                                          hint: const Text(
                                            'Relation With Guardian',
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
                                          items: items
                                              .map<DropdownMenuItem<String>>(
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
                                      Row(
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
                                              fontSize: 25,
                                              color: Colors.blue,
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
                                              fontSize: 25,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                'Booking Type',
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
                                    snapshot.data![index].BookingType
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Package Name',
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
                                    snapshot.data![index].PackageName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Total Price',
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
                                    snapshot.data![index].TotalPrice.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Duration',
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
                                    snapshot.data![index].Duration.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Stay Duration',
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
                                    snapshot.data![index].StayDuration
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Package Details',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.black,
                                  )),
                                  child: Text(
                                    snapshot.data![index].PackageDetails
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
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
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Request();
                    showAlertDialog(context);
                  },
                  child: Text('Send Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
