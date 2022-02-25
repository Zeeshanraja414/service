import 'dart:convert';
import 'package:old/oldhomeproject/adminOldHomeSide.dart';
import "package:flutter/material.dart";
import 'package:old/oldhomeproject/register.dart';
import 'package:http/http.dart' as http;
import 'package:old/oldhomeproject/url.dart';
import 'package:old/oldhomeproject/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController UserNameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController UserTypeController = TextEditingController();
  TextEditingController IdController = TextEditingController();
  int i = 0;
  late Future<int> futurePost;

  late String UserName, Password;
  late bool error, sending, success;
  late String msg;
  String url = "http://${IpAdress.ip}/OldHome1/api/oldhome/login";
  late String Username;
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;

    super.initState();
  }

  Future<void> login() async {
    var res = await http.post(Uri.parse(url), body: {
      'Id': IdController.text,
      'UserName': UserNameController.text,
      'Password': PasswordController.text,
      'UserType': UserTypeController.text,
    });
    if (res.statusCode == 200) {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool login = prefs.getBool('isLoggedIn') ?? false;
      var email = prefs.getString(UserNameController.text);
      var pass = prefs.getString(PasswordController.text);
      var data = json.decode(res.body);
      int id = data['Id'];
      i = data['Id'];
      String FullName = data['FullName'];
      print(id);
      if (data['UserType'] == 'oldhome') {
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Admin(
                        id: id,
                        idp: id,
                        ids: id,
                      )));
        });
      }
      if (data['UserType'] == 'user') {
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => User(
                        Fullname: FullName,
                        uid: id,
                      )));
        });
      }
    } else {
      setState(() {
        showAlertDialog(context);
        print('Login Failed');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 150.0,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'LOG IN',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 50),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: UserNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: PasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {
                      login();
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  FlatButton(
                    textColor: Colors.blue,
                    child: const Text(
                      'Registration',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
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
  Future.delayed(Duration(seconds: 1), () {
    Navigator.of(context).pop(true);
  });
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Login Failed"),
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
