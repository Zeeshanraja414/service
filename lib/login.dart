import 'dart:convert';
import 'package:old/admin.dart';
import "package:flutter/material.dart";
import 'package:old/register.dart';
import 'package:http/http.dart'as http;
import 'package:old/user.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController UserNameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController UserTypeController = TextEditingController();
  late String UserName, Password;
  late bool error, sending, success;
  late String msg;
  String url ="http://192.168.150.115/OldHome1/api/oldhome/login";
  late String Username;

  @override

  void initState(){
    error = false;
    sending = false;
    success = false;
    super.initState();
  }
  Future<void> login() async{
    var res=await http.post(Uri.parse(url),body: {
      'UserName':UserNameController.text,
      'Password':PasswordController.text,
      'UserType':UserTypeController.text,
    });
    if (res.statusCode==200){
      print(res.body);
      var data = json.decode(res.body);
      if (data['UserType'] == 'oldhome'){
        setState(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Admin()));
        });
      }
      if (data['UserType'] == 'user'){
        setState(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const User()));
        });
      }
      if(data["error"]){
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      }
      else{
        UserNameController.text='';
        PasswordController.text='';


        setState(() {
          sending=false;
          success=true;
        });
      }
    }
    else{
      setState(() {
        error=true;
        msg="Error during sending data";
        sending=false;
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
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      //Navigator.push(context,
                          //MaterialPageRoute(builder: (context) => hhcAdmin()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Signup()));
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