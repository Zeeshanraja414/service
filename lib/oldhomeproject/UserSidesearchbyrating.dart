import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:old/oldhomeproject/Usersiteoldhomedetails.dart';
import 'package:old/oldhomeproject/url.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
    required this.Rating,
    required this.Cost,
  });
  var Rating;
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
  var Cost;

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
        Rating: json["Rating"],
        Cost: json["Cost"],
      );
}

class SearchbyRanking extends StatefulWidget {
  String drop;
  String User;
  int uid;
  SearchbyRanking(
      {Key? key, required this.drop, required this.uid, required this.User})
      : super(key: key);

  @override
  _SearchbyRankingState createState() => _SearchbyRankingState();
}

class _SearchbyRankingState extends State<SearchbyRanking> {
  Future<List<Search>> searchOld() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/searchbyranking?city=${widget.drop}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Search>((json) => Search.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  //late Future<List<Search>> futureSearch;
  @override
  void initState() {
    searchOld();
    super.initState();
  }

  List<String> items = ['Rawalpindi', 'Islamabad'];

  String dropdownValue = 'Rawalpindi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Old Homes By Rank'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   child: DropdownButton<String>(
            //     isExpanded: true,
            //     autofocus: true,
            //     focusColor: Colors.white,
            //     hint: const Text(
            //       'Select City',
            //       style: TextStyle(
            //         fontWeight: FontWeight.w300,
            //         fontSize: 20,
            //         color: Colors.teal,
            //       ),
            //     ),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         dropdownValue = newValue!;
            //       });
            //     },
            //     value: dropdownValue,
            //     items: items.map((item) {
            //       return DropdownMenuItem(
            //         child: new Text(item),
            //         value: item,
            //       );
            //     }).toList(),
            //     dropdownColor: Colors.white,
            //   ),
            // ),
            FutureBuilder<List<Search>>(
                future: searchOld(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 4,
                                )),
                            child: TextButton(
                              onPressed: () {
                                var ss = snapshot.data![index].FullName;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OldHomeDetails(
                                              oldhome: ss,
                                              FullName: widget.User,
                                              uid: widget.uid,
                                            )));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Text(
                                    'Old Home Name  :',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 170),
                                    child: Text(
                                      snapshot.data![index].FullName,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                    child: Text(
                                      'City                         :',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        170, 35, 0, 0),
                                    child: Text(
                                      snapshot.data![index].City,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 70, 0, 0),
                                    child: Text(
                                      'Gender                   :',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        170, 70, 0, 0),
                                    child: Text(
                                      snapshot.data![index].Gender,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 105, 0, 0),
                                    child: Text(
                                      'Cost                        :',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        170, 105, 0, 0),
                                    child: Text(
                                      snapshot.data![index].Cost.toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 140),
                                    child: Center(
                                      child: SmoothStarRating(
                                        rating: snapshot.data![index].Rating,
                                        starCount: 5,
                                        isReadOnly: true,
                                        size: 25,
                                        spacing: 3,
                                        allowHalfRating: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}
