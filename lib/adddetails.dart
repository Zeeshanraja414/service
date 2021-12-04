// /*import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
// import 'dart:convert';
// import 'package:old/fetchmodel.dart';
//
// Future<List<Post>> fetchPost() async {
//   final response =
//   await http.get(Uri.parse("http://192.168.10.3/OldHome1/api/oldhome/AllRegister"));
//
//   if (response.statusCode == 200) {
//     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//
//     return parsed.map<Post>((json) => Post.fromMap(json)).toList();
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
//
// class Details extends StatefulWidget {
//   const Details({Key? key}) : super(key: key);
//
//   @override
//   _DetailsState createState() => _DetailsState();
// }
//
// class _DetailsState extends State<Details> {
//   List<String> items=<String>[
//     'Male',
//     'Female',
//   ];
//   String dropdownValue ='Male';
//   TextEditingController FnameController = TextEditingController();
//   TextEditingController PhonenumController = TextEditingController();
//   TextEditingController EmailController = TextEditingController();
//   TextEditingController AddressController = TextEditingController();
//   TextEditingController UsernameController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//   TextEditingController CityController = TextEditingController();
//   //String url ="http://192.168.10.3/OldHome1/api/oldhome/AllRegister";
//   late Future<List<Post>> futurePost;
//   @override
//   void initState() {
//     super.initState();
//     futurePost = fetchPost();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text('Add Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextFormField(
//                   controller: FnameController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'OldHome Name',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextFormField(
//                   controller: AddressController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Contact Number',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextFormField(
//                   controller: PhonenumController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Address',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextFormField(
//                   controller: EmailController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'City',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextFormField(
//                   controller: UsernameController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Vacant Seats',
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0,right: 20),
//                 child: DropdownButton<String>(
//                    isExpanded: true,
//                   onChanged: (String? newValue){
//                     setState(() {
//                       dropdownValue = newValue!;
//                     });
//                   },
//                   value: dropdownValue,
//                   items: items.map<DropdownMenuItem<String>>(
//                       (String value){
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       },
//                   ).toList(),
//                 ),
//               ),
//               const SizedBox(height: 20,),
//               Container(
//                 height: 60,
//                 width: 200,
//                 padding: const EdgeInsets.all(10),
//                 child: TextButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all<Color>(Colors.blue),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                     ),
//                   ),
//                   child: const Text(
//                     'Save',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: () {
//                     // Navigator.push(context,
//                     //MaterialPageRoute(builder: (context) => LoginPage()));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }*/
//
//
// import 'package:flutter/material.dart';
// // import 'package:old/fetchmodel.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
//
// Future<Album> fetchAlbum() async {
//   try{
//     final response = await http
//         .post(Uri.parse('http://192.168.10.16/OldHome1/api/oldhome/searchbyusername?UserName=Zeeshan'));
//     print(jsonDecode(response.body));
//     //final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//     //return parsed.map<Post>((json) => Post.fromMap(json)).toList();
//   }catch(e){
//     print(e);
//   }
//   final response = await http
//       .get(Uri.parse('http://192.168.10.16/OldHome1/api/oldhome/searchbyusername?UserName=Zeeshan'));
//
//   return Album.fromJson(jsonDecode(response.body));
// }
//
//
// class Album {
//
//   String FullName;
//   String ContactNo;
//   String City;
//
//   Album({
//
//     required this.FullName,
//     required this.ContactNo,
//     required this.City,
//   });
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       FullName: json['FullName'],
//       ContactNo: json['ContactNo'],
//       City: json['City'],
//     );
//   }
// }
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//
//   var FullName = TextEditingController();
//   var ContactNo= TextEditingController();
//   var Address= TextEditingController();
//   var City = TextEditingController();
//   late Future<Album> futureAlbum;
//
//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }
//
//   @override
//  Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: FutureBuilder<List<Album>>(
//           future: futureAlbum,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               //var snap=snapshot.data;
//               return(Text(snapshot.data!.FullName));
//
//               // return ListView.builder(
//               //   itemCount: snapshot.data!.length,
//               //   itemBuilder: (_, index) {
//               //     return ListTile(
//               //       title: Text(snapshot.data![index].FullName),
//               //       subtitle: Column(
//               //         children: [
//               //           Text(snapshot.data![index].FullName),
//               //           Text(snapshot.data![index].Address),
//               //           Text(snapshot.data![index].Address),
//               //           Text(snapshot.data![index].City),
//               //         ],
//               //       ),
//               //
//               //     );
//
//                   // return ListTile(
//                   //      //  //snapshot.data![index].FullName,
//                   //      // // snapshot.data![index].ContactNo,
//                   //      //  snapshot.data![index].City,
//                   //      //  snapshot.data![index].Address,
//                   //      //  snapshot.data![index].FullName,
//                   //
//                   //
//                   //
//                   //   leading:
//                   //  Image.network(snapshot.data![index].thumbImageURL),
//                   //   title: Text(snapshot.data![index].FullName),
//                   //   subtitle: Column(
//                   //     children: [
//                   //       Text(snapshot.data![index].ContactNo),
//                   //       Row(
//                   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //         children: [
//                   //           Text(
//                   //             String.fromCharCodes(Runes(
//                   //               'City: \u0024${snapshot.data![index].City}',
//                   //             )),
//                   //             style: const TextStyle(
//                   //                 color: Colors.black, fontWeight: FontWeight.w600),
//                   //           ),
//                   //           Text(
//                   //             'Address :${snapshot.data![index].Address}',
//                   //             style: const TextStyle(
//                   //                 color: Colors.black, fontWeight: FontWeight.w600),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ],
//                   //   ),
//                   //   trailing: IconButton(
//                   //       onPressed: () {}, icon: const Icon(Icons.favorite_border)),
//                   // );
//
//               },);
//             }
//             else if(snapshot.hasError){
//               return Center(child: Text('${snapshot.error}'));
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }
//   /*Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: const Text('NFC READER'),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(50),
//         width: double.infinity,
//         child: Column(
//           children: <Widget>[
//             new Container(
//               margin: const EdgeInsets.fromLTRB(10, 10, 10, 40),
//               child: new RaisedButton(
//                 child: Text("Read NFC"),
//                 onPressed: () {
//                   FlutterNfcReader.read().then((response) {
//                     setState(() {
//                       print(response.content);
//                       //response.content is the NFC result;
//                       // here what to do ?
//                     });
//                   });
//                 },
//                 color: Colors.red,
//                 textColor: Colors.white,
//                 padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                 splashColor: Colors.grey,
//               ),
//             ),
//             new Text(
//               s,
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 0, bottom: 25.0, left: 0, right: 0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'First Name',
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 readOnly: true,
//                 controller: fname,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 0, bottom: 25.0, left: 0, right: 0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Middle Name',
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 readOnly: true,
//                 controller: fname,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 0, bottom: 25.0, left: 0, right: 0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Last Name',
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 readOnly: true,
//                 controller: fname,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 0, bottom: 25.0, left: 0, right: 0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Number',
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 readOnly: true,
//                 controller: fname,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 0, bottom: 25.0, left: 0, right: 0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Course',
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 readOnly: true,
//                 controller: fname,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }*/
// // }
//
//
//
//
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   late Future<Album> futureAlbum;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     futureAlbum = fetchAlbum();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Fetch Data Example',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Fetch Data Example'),
// //         ),
// //         body: Center(
// //           child: FutureBuilder<Album>(
// //             future: futureAlbum,
// //             builder: (context, snapshot) {
// //               if (snapshot.hasData) {
// //                 return
// //                   Text(snapshot.data!.City);
// //
// //
// //               } else if (snapshot.hasError) {
// //                 return Text('${snapshot.error}');
// //               }
// //
// //               // By default, show a loading spinner.
// //               return const CircularProgressIndicator();
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class detail {
  String Id;
  String FullName;
  String ConatactNo;
  String Address;
  String City;
  detail({
    required this.Id,
    required this.FullName,
    required this.ConatactNo,
    required this.Address,
    required this.City,
  });
  factory detail.fromJson(Map<String, dynamic> json) {
    return detail(
      Id: json['Id'].toString(),
      FullName: json['FullName'],
      ConatactNo: json['ConatctNo'],
      Address: json['Address'],
      City: json['City'],
    );
  }
}
Future<List<detail>> fetchdetail() async {
  final response = await http
      .get(Uri.parse('http://192.168.150.115/OldHome1/api/oldhome/search'));
  if (response.statusCode == 200) {
    List paresd = jsonDecode(response.body);
    print(paresd);


    return paresd.map((emp) => detail.fromJson(emp)).toList();
    // return org.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

 late Future<List<detail>> futuredetail;
@override
void initState() {
initState();
   futuredetail=fetchdetail();
}

  class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController FnameController = TextEditingController();
  TextEditingController PhonenumController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController VacantController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<detail>>(
                future: futuredetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                child: Container(
                                  height: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data![index].FullName,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].ConatactNo,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 15,
                                          //fontWeight: FontWeight.w500,
                                          //color: Colors.teal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 75,
                                          ),
                                          Text(
                                            snapshot.data![index].Address,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            " | ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].City,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          // Text(
                                          //   snapshot.data![index].Id,
                                          //   textAlign: TextAlign.right,
                                          //   style: TextStyle(
                                          //     fontSize: 15,
                                          //   ),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    // Text(snapshot.data!.name);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              )
            ]
          ),
        ),
      ),
    );
  }
}

