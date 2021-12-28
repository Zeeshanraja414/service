import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    required this.BookingType,
    required this.PackageName,
    required this.PackageDetails,
    required this.Duration,
    required this.TotalPrice,
  });

  var BookingType;
  var PackageName;
  var PackageDetails;
  var Duration;
  var TotalPrice;


  factory Post.fromMap(Map<String, dynamic> json) => Post(
    BookingType: json["BookingType"],
    PackageName: json["PackageName"],
    PackageDetails: json["PackageDetails"],
    Duration: json["Duration"],
    TotalPrice: json["TotalPrice"],
  );
}

class Silver extends StatefulWidget {
  const Silver({Key? key}) : super(key: key);

  @override
  _SilverState createState() => _SilverState();
}

class _SilverState extends State<Silver> {
  Future<List<Post>> fetchPost() async {
    final response = await http
        .get(Uri.parse('http://192.168.10.5/OldHome1/api/oldhome/packagedetails?name=Gold'));
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Package Details'),
        ),
        body: FutureBuilder<List<Post>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
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
                              snapshot.data![index].PackageName.toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:20),
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
                        SizedBox(height:20),
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
                        SizedBox(height:20),
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
                              snapshot.data![index].PackageDetails.toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:20),
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
                              snapshot.data![index].BookingType.toString(),
                              style: TextStyle(
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
      ),
    );
  }
}
