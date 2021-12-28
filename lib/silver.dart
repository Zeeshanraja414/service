import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

getData() async{
 Uri url=Uri.parse('192.168.10.6/OldHome1/api/oldhome/search');
 var response=await http.get(url);
 try {
   if (response.statusCode==200){
     print(response.body);
   }
 } on Exception catch (e) {
   // TODO
   print("Exception");
 }

}
class Lala extends StatefulWidget {
  const Lala({Key? key}) : super(key: key);

  @override
  _LalaState createState() => _LalaState();
}

class _LalaState extends State<Lala> {

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('user'),
          ),
        ],
      ),
    );
  }
}
