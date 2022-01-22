import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/Usersiteoldhomedetails.dart';
import 'package:old/oldhomeproject/url.dart';

class Search {
  Search({
    required this.Id,
    required this.FullName,
    required this.ContactNo,
    required this.Address,
    required this.City,
    required this.UserName,
    required this.Email,
    required this.TotalSeats,
    required this.VacantSeats,
    required this.Gender,
  });
  var Id;
  var UserName;
  var FullName;
  var ContactNo;
  var Address;
  var City;
  var Email;
  var TotalSeats;
  var VacantSeats;
  var Gender;

  factory Search.fromMap(Map<String, dynamic> json) => Search(
        Id: json["Id"],
        UserName: json["UserName"],
        FullName: json["FullName"],
        ContactNo: json["ContactNo"],
        Address: json["Address"],
        City: json["City"],
        Email: json["Email"],
        TotalSeats: json["TotalSeats"],
        VacantSeats: json["VacantSeats"],
        Gender: json["Gender"],
      );
}

class OldHomeName extends StatefulWidget {
  final String Name;
  final String City;
  final String Gender;
  String Fullname;
  int uid;

  OldHomeName({
    Key? key,
    required this.Name,
    required this.City,
    required this.Gender,
    required this.Fullname,
    required this.uid,
  }) : super(key: key);

  @override
  _OldHomeNameState createState() => _OldHomeNameState();
}

class _OldHomeNameState extends State<OldHomeName> {
  Future<List<Search>> searchOld() async {
    if (widget.Gender == '' && widget.Name == '') {
      final response = await http.get(Uri.parse(
          'http://${IpAdress.ip}/OldHome1/api/oldhome/SearchByCity?city=${widget.City}'));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Search>((json) => Search.fromMap(json)).toList();
      } else {
        throw Exception('Failed');
      }
    } else if (widget.Gender == '' && widget.City == '') {
      final response = await http.get(Uri.parse(
          'http://${IpAdress.ip}/OldHome1/api/oldhome/SearchName?fullname=${widget.Name}'));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Search>((json) => Search.fromMap(json)).toList();
      } else {
        throw Exception('Failed');
      }
    } else if (widget.Name == '' && widget.City == '') {
      final response = await http.get(Uri.parse(
          'http://${IpAdress.ip}/OldHome1/api/oldhome/SearchByGender?gender=${widget.Gender}'));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Search>((json) => Search.fromMap(json)).toList();
      } else {
        throw Exception('Failed');
      }
    } else if (widget.Gender == '') {
      final response = await http.get(Uri.parse(
          'http://${IpAdress.ip}/OldHome1/api/oldhome/SearchCityandName?city=${widget.City}&name=${widget.Name}'));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Search>((json) => Search.fromMap(json)).toList();
      } else {
        throw Exception('Failed');
      }
    } else if (widget.Name == '') {
      final response = await http.get(Uri.parse(
          'http://${IpAdress.ip}/OldHome1/api/oldhome/searchcityandgender?City=${widget.City}&Gender=${widget.Gender}'));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Search>((json) => Search.fromMap(json)).toList();
      } else {
        throw Exception('Failed');
      }
    }
    // else if (widget.City == '') {
    //   final response = await http.get(Uri.parse(
    //       'http://${IpAdress.ip}/OldHome1/api/oldhome/Searchnameandgender?name=${widget.Name}&Gender=${widget.Gender}'));
    //   if (response.statusCode == 200) {
    //     print(jsonDecode(response.body));
    //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    //     return parsed.map<Search>((json) => Search.fromMap(json)).toList();
    //   } else {
    //     throw Exception('Failed');
    //   }
    // }
    else if (widget.City != '' && widget.Name != '' && widget.Gender != '') {
      final response = await http.get(Uri.parse(
          'http://${IpAdress.ip}/OldHome1/api/oldhome/searchfull?city=${widget.City}&gender=${widget.Gender}&name=${widget.Name}'));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Search>((json) => Search.fromMap(json)).toList();
      } else {
        throw Exception('Failed');
      }
    }
    print('error');
    return name;
  }

  late Future<List<Search>> futureSearch;
  @override
  void initState() {
    futureSearch = searchOld();
    super.initState();
  }

  var name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Old Home'),
        leading: BackButton(onPressed: () => Navigator.of(context).pop(true)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<Search>>(
                  future: futureSearch,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: TextButton(
                                    onPressed: () {
                                      name = snapshot.data![index].FullName
                                          .toString();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OldHomeDetails(
                                                    oldhome: name,
                                                    FullName: widget.Fullname,
                                                    uid: widget.uid,
                                                  )));
                                    },
                                    child: Text(
                                      snapshot.data![index].FullName.toString(),
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  subtitle: Center(
                                    child: Text(
                                      snapshot.data![index].City.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          185, 8, 0, 0),
                                      child: Text(
                                        snapshot.data![index].Gender.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
