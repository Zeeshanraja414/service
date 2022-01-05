import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/searchpackagenameusersite.dart';
import 'dart:convert';
import 'package:old/oldhomeproject/url.dart';
import 'Packagesdetailuserside.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    required this.Pid,
    required this.BookingType,
    required this.PackageName,
    required this.PackageDetails,
    required this.Duration,
    required this.TotalPrice,
    required this.StayDuration,
  });
  var Pid;
  var BookingType;
  var PackageName;
  var PackageDetails;
  var Duration;
  var TotalPrice;
  var StayDuration;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        Pid: json["Pid"],
        BookingType: json["BookingType"],
        PackageName: json["PackageName"],
        PackageDetails: json["PackageDetails"],
        Duration: json["Duration"],
        TotalPrice: json["TotalPrice"],
        StayDuration: json["StayDuration"],
      );
}

class PackageType extends StatefulWidget {
  int id;
  String FullName;
  int uid;
  String OldhomeName;
  PackageType(
      {Key? key,
      required this.id,
      required this.FullName,
      required this.uid,
      required this.OldhomeName})
      : super(key: key);

  @override
  _PackageTypeState createState() => _PackageTypeState();
}

class _PackageTypeState extends State<PackageType> {
  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/packagedetail?id=${widget.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((json) => Post.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  late Future<List<Post>> futurePost;
  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  Object? _value = '';
  var life;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Type'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Radio(
                  value: 'BookforYourself',
                  activeColor: Colors.blue,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              const Text(
                'For Yourself',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Radio(
                value: 'BookforOther',
                activeColor: Colors.blue,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              const Text(
                'For Other',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPackage(
                              id: widget.id,
                              type: _value,
                              FUllNAme: widget.FullName,
                              uid: widget.uid,
                              OldhomeName: widget.OldhomeName,
                            )));
              });
            },
            child: Text('Search'),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'All Packages',
            style: TextStyle(
              fontSize: 26,
            ),
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
                    itemBuilder: (_, index) {
                      return Container(
                        child: TextButton(
                          onPressed: () {
                            life = snapshot.data![index].PackageName;
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PackagedetailUser(
                                            OHid: widget.id,
                                            name: life,
                                            FullNAme: widget.FullName,
                                            uid: widget.uid,
                                            OldhomeName: widget.OldhomeName,
                                          )));
                            });
                          },
                          child: Text(
                            snapshot.data![index].PackageName.toString(),
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
