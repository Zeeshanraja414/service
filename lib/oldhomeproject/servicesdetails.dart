import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/url.dart';
import 'package:getwidget/getwidget.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.Id,
    this.serviceId,
    this.name,
    this.serviceName,
  });

  var Id;
  var serviceId;
  var name;
  var serviceName;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        Id: json["Id"],
        serviceId: json["ServiceId"],
        name: json["name"],
        serviceName: json["ServiceName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "ServiceId": serviceId,
        "name": name,
        "ServiceName": serviceName,
      };
}

class ServicesDetails extends StatefulWidget {
  final String packagename;
  int id;
  ServicesDetails({
    Key? key,
    required this.packagename,
    required this.id,
  }) : super(key: key);
  @override
  _ServicesDetailsState createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  var id;
  late Future<List<Post>> futurePost;
  late final ImageErrorWidgetBuilder? errorBuilder;
  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/servicesimage?Imagee=${widget.packagename}&id=${widget.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  @override
  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Of Services'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    id = snapshot.data![index].Id;
                    return Container(
                      child: Column(
                        children: [
                          // Text(
                          //   snapshot.data![index].serviceName.toString(),
                          //   style: TextStyle(
                          //     fontSize: 35,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GFAvatar(
                              radius: 180,
                              shape: GFAvatarShape.square,
                              backgroundImage: NetworkImage(
                                "http://${IpAdress.ip}/OldHome1/Uploads/${snapshot.data![index].name}",
                              ),
                            ),
                          ),
                        ],
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
      // floatingActionButton: FloatingActionButton(
      //   foregroundColor: Colors.black,
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Multiimage()));
      //   },
      // ),
    );
  }
}
