import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:old/oldhomeproject/url.dart';

// List<Post> postFromJson(String str) =>
//     List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
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
    required this.UserType,
    required this.Password,
    required this.Cost,
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
  var Password;
  var UserType;
  var Cost;
  factory Post.fromMap(Map<String, dynamic> json) => Post(
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
        UserType: json["UserType"],
        Password: json["Password"],
        Cost: json["Cost"],
      );
}

class Detail extends StatefulWidget {
  final int id;
  Detail({Key? key, required this.id}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  TextEditingController IdController = TextEditingController();
  TextEditingController FullNameController = TextEditingController();
  TextEditingController ContactNoController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController TotalSeatsController = TextEditingController();
  TextEditingController VacantSeatsController = TextEditingController();
  TextEditingController UserNameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController UserTypeController = TextEditingController();
  TextEditingController CostController = TextEditingController();

  late bool error, sending, success;
  late String msg;
  Object? _value = 'Male';
  late Future<List<Post>> futurePost;

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
    futurePost = fetchPost();
  }

  Future<void> send() async {
    var res = await http.post(
      Uri.parse(('http://${IpAdress.ip}/OldHome1/api/oldhome/updatedetails')),
      body: {
        'Id': IdController.text,
        'FullName': FullNameController.text,
        'ContactNo': ContactNoController.text,
        'Email': EmailController.text,
        'Address': AddressController.text,
        'City': CityController.text,
        'VacantSeats': VacantSeatsController.text,
        'Gender': _value.toString(),
        'TotalSeats': TotalSeatsController.text,
        'UserName': UserNameController.text,
        'Password': PasswordController.text,
        'UserType': UserTypeController.text,
        'Rating': 0.toString(),
        'Cost': CostController.text.toString(),
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        IdController.text = '';
        FullNameController.text = '';
        ContactNoController.text = '';
        EmailController.text = '';
        AddressController.text = '';
        CityController.text = '';
        VacantSeatsController.text = '';
        _value = '';
        TotalSeatsController.text = '';
        UserNameController.text = '';
        UserTypeController.text = '';
        PasswordController.text = '';
        setState(() {
          sending = false;
          success = true;
        });
      }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://${IpAdress.ip}/OldHome1/api/oldhome/search?Id=${widget.id}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((json) => Post.fromMap(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('OLD HOME DETAILS'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Post>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  IdController.text = snapshot.data![index].Id.toString();
                  UserNameController.text =
                      snapshot.data![index].UserName.toString();
                  UserTypeController.text =
                      snapshot.data![index].UserType.toString();
                  PasswordController.text =
                      snapshot.data![index].Password.toString();
                  FullNameController.text =
                      snapshot.data![index].FullName.toString();
                  ContactNoController.text =
                      snapshot.data![index].ContactNo.toString();
                  EmailController.text = snapshot.data![index].Email.toString();
                  AddressController.text =
                      snapshot.data![index].Address.toString();
                  CityController.text = snapshot.data![index].City.toString();
                  TotalSeatsController.text =
                      snapshot.data![index].TotalSeats.toString();
                  VacantSeatsController.text =
                      snapshot.data![index].VacantSeats.toString();
                  CostController.text = snapshot.data![index].Cost.toString();
                  SizedBox(height: 30);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: FullNameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Name"),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: ContactNoController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Conatct No"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: EmailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: AddressController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Address"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: CityController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "City"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            Radio(
                                value: 'Male',
                                activeColor: Colors.blue,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                            const Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Radio(
                              value: 'Female',
                              activeColor: Colors.blue,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                            ),
                            const Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: CostController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Cost Per Month"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: TotalSeatsController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Total Seats"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: VacantSeatsController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Vacant Seats"),
                      ),
                      SizedBox(height: 20),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            send();
                            setState(() {
                              showAlertDialog(context);
                            });
                          },
                          child: const Text(
                            "Save",
                          )),
                    ],
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

showAlertDialog(BuildContext context) {
  // set up the button
  // TextButton(
  //   child: Text("Ok"),
  //   onPressed: () {
  // Navigator.of(context).pop;
  //   },
  // );
  // Future.delayed(Duration(seconds: 2), () {
  //   Navigator.of(context).pop(true);
  // });
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Data Saved Successfully"),
    //content: Text(""),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
