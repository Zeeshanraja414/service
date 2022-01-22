import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/packagesdetailOldHomeSide.dart';
import 'dart:convert';
import 'package:old/oldhomeproject/url.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    required this.BookingType,
    required this.PackageName,
    required this.PackageDetails,
    required this.Duration,
    required this.TotalPrice,
    required this.StayDuration,
  });

  var BookingType;
  var PackageName;
  var PackageDetails;
  var Duration;
  var TotalPrice;
  var StayDuration;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        BookingType: json["BookingType"],
        PackageName: json["PackageName"],
        PackageDetails: json["PackageDetails"],
        Duration: json["Duration"],
        TotalPrice: json["TotalPrice"],
        StayDuration: json["StayDuration"],
      );
}

class ViewPackageName extends StatefulWidget {
  int idpu;
  String FullName;
  ViewPackageName({
    Key? key,
    required this.idpu,
    required this.FullName,
  }) : super(key: key);

  @override
  _ViewPackageNameState createState() => _ViewPackageNameState();
}

class _ViewPackageNameState extends State<ViewPackageName> {
  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/packagedetail?Id=${widget.idpu}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((json) => Post.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  var life;
  late Future<List<Post>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Packages'),
        ),
        resizeToAvoidBottomInset: true,
        body: FutureBuilder<List<Post>>(
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
                          setState(() {
                            var life =
                                snapshot.data![index].PackageName.toString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Packagedetail(
                                          name: life,
                                          id: widget.idpu,
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
      ),
    );
  }
}
