import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/servicesdetails.dart';
import 'package:old/oldhomeproject/url.dart';

List<Post> fetchFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({this.ServiceName});

  var ServiceName;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        ServiceName: json["ServiceName"],
      );

  Map<String, dynamic> toJson() => {
        "ServiceName": ServiceName,
      };
}

class ServiceNameUser extends StatefulWidget {
  int idsu;
  ServiceNameUser({
    Key? key,
    required this.idsu,
  }) : super(key: key);
  @override
  _ServiceNameUserState createState() => _ServiceNameUserState();
}

class _ServiceNameUserState extends State<ServiceNameUser> {
  Future fetchPost() async {
    var url = Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/zeeshan?Id=${widget.idsu}');
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data);
        print(decodedData);
        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  @override
  @override
  void initState() {
    super.initState();
  }

  var packagename;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Services'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchPost(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    return Container(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              packagename = snapshot.data![index];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ServicesDetails(
                                            packagename: packagename,
                                            id: widget.idsu,
                                          )));
                            },
                            child: Text(
                              snapshot.data![index],
                              style: const TextStyle(
                                fontSize: 35,
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
    );
  }
}
