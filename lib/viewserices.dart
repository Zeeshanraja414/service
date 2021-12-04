import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:old/Models/Service.dart';
import 'package:old/core/constant.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
late Future<Service> serviceImages;

@override
void initState() {
    // TODO: implement initState
  serviceImages = fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('List Of Images'),
        centerTitle: true,
      ),
       body: Center(
    child: FutureBuilder<Service>(future: serviceImages,builder: (context, snapshot){
      if (snapshot.hasData){
        return Text(snapshot.data!.serviceName!);
      }
      else if (snapshot.hasError){
        return Text('${snapshot.error}');
      }
      return CircularProgressIndicator();
    },),

),
    );
  }
}
Future<Service> fetchImage() async{
  final response = await http.get(Uri.parse(Constant.ApiAdress));
  final jsonResponse = json.decode(response.body);

  if (response.statusCode == 200){
    return Service.fromMap(jsonDecode(jsonResponse));
  }
  else{
    throw Exception("Failed to load information");
  }
}
