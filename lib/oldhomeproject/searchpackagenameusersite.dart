import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/Packagesdetailuserside.dart';
import 'package:old/oldhomeproject/packagesdetail.dart';
import 'dart:convert';
import 'package:old/addpackages.dart';
import 'package:old/url.dart';

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

class SearchPackage extends StatefulWidget {
  final int id;
  var type;
  SearchPackage({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _SearchPackageState createState() => _SearchPackageState();
}

class _SearchPackageState extends State<SearchPackage> {
  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://192.168.10.9/OldHome1/api/oldhome/PackageSearch?type=${widget.type}&Id=${widget.id}'));
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          life = snapshot.data![index].PackageName.toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PackagedetailUser(
                                        name: life,
                                        id: widget.id,
                                      )));
                        });
                      },
                      child: Text(
                        snapshot.data![index].PackageName.toString(),
                        style: TextStyle(
                          fontSize: 35,
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
