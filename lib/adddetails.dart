// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// List<Post> postFromJson(String str) =>
//     List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));
//
// class Post {
//   Post({
//     required this.FullName,
//     required this.ContactNo,
//     required this.Address,
//     required this.City,
//     required this.UserName,
//     required this.Email,
//   });
//
//   var UserName;
//   var FullName;
//   var ContactNo;
//   var Address;
//   var City;
//   var Email;
//
//   factory Post.fromMap(Map<String, dynamic> json) => Post(
//     UserName: json["UserName"],
//     FullName: json["FullName"],
//     ContactNo: json["ContactNo"],
//     Address: json["Address"],
//     City: json["City"],
//     Email: json["Email"],
//   );
// }
//
// class Detail extends StatefulWidget {
//   const Detail({Key? key}) : super(key: key);
//
//   @override
//   _DetailState createState() => _DetailState();
// }
//
// class _DetailState extends State<Detail> {
//   Future<List<Post>> fetchPost() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.10.4/OldHome1/api/oldhome/search'));
//     if (response.statusCode == 200) {
//       print(jsonDecode(response.body));
//       final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//       return parsed.map<Post>((json) => Post.fromMap(json)).toList();
//     } else {
//       throw Exception('Failed');
//     }
//   }
//   Object? _value = 'Male';
//   late Future<List<Post>> futurePost;
//
//   @override
//   void initState() {
//     super.initState();
//     futurePost = fetchPost();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Details'),
//         ),
//         body: FutureBuilder<List<Post>>(
//           future: futurePost,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (_, index) {
//                   return Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       children: [
//                         Card(
//                           child: Container(
//                             height: 40,
//                             width: 350,
//                             padding: EdgeInsets.only(top: 12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )),
//                             child: Text(
//                               snapshot.data![index].FullName.toString(),
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Card(
//                           child: Container(
//                             height: 40,
//                             width: 350,
//                             padding: EdgeInsets.only(top: 12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )),
//                             child: Text(
//                               snapshot.data![index].ContactNo.toString(),
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Card(
//                           child: Container(
//                             height: 40,
//                             width: 350,
//                             padding: EdgeInsets.only(top: 12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )),
//                             child: Text(
//                               snapshot.data![index].Email.toString(),
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Card(
//                           child: Container(
//                             height: 40,
//                             width: 350,
//                             padding: EdgeInsets.only(top: 12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )),
//                             child: Text(
//                               snapshot.data![index].Address.toString(),
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Card(
//                           child: Container(
//                             height: 40,
//                             width: 350,
//                             padding: EdgeInsets.only(top: 12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )),
//                             child: Text(
//                               snapshot.data![index].City.toString(),
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Card(
//                           child: Container(
//                             height: 40,
//                             width: 350,
//                             // padding: EdgeInsets.only(top: 12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )),
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 hintText: "Total Seats",
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Card(
//                           child: Container(
//                             height: 40,
//                             width: 350,
//                             padding: EdgeInsets.only(top: 12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )
//                             ),
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 hintText: "Vacant Seats",
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Row(
//                           children: [
//                             Radio(value:'Male',
//                                 activeColor: Colors.blue,
//                                 groupValue:_value, onChanged:(value){
//                                   setState(() {
//                                     _value=value;
//                                   });
//                                 }
//                             ),
//
//                             const Text('Male',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                               ),),
//                             const SizedBox(width: 50,),
//                             Radio(value:'Female',
//                               activeColor: Colors.blue,
//                               groupValue:_value, onChanged:(value){
//                                 setState(() {
//                                   _value=value;
//                                 }
//                                 );
//                               },
//                             ),
//
//                             const Text('FeMale',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height:20),
//                         ElevatedButton(onPressed: (){}, child: Text(
//                           "Save",
//                         ))
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Center(child: Text('${snapshot.error}'));
//             }
//
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }
