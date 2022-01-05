import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:old/oldhomeproject/url.dart';
import 'package:http/http.dart' as http;

class Multiimage extends StatefulWidget {
  int id;
  Multiimage({Key? key, required this.id}) : super(key: key);

  @override
  _MultiimageState createState() => _MultiimageState();
}

class _MultiimageState extends State<Multiimage> {
  List<Asset> images = [];
  Dio dio = Dio();

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  TextEditingController ServiceNameController = TextEditingController();
  //Object? _value = 'user';
  late bool error, sending, success;
  late String msg;
  String url = "http://${IpAdress.ip}/OldHome1/api/oldhome/addservice";

  Future<void> sendName() async {
    var res = await http.post(Uri.parse(url), body: {
      'ServiceName': ServiceNameController.text,
      'Id': widget.id.toString(),
      //'name': ,
    });
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
        ServiceNameController.text = '';
        widget.id = '' as int;
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

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  String BASE_URL = "http://${IpAdress.ip}/OldHome1/api/oldhome/addservices";

  _saveImage() async {
    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        ByteData byteData = await images[i].getByteData();
        List<int> imageData = byteData.buffer.asInt8List();
        MultipartFile multipartFile = MultipartFile.fromBytes(
          imageData,
          filename: images[i].name,
          contentType: MediaType('image', 'jpg'),
        );
        FormData formData = FormData.fromMap({
          "name": multipartFile,
          "ServiceName": ServiceNameController.text,
          //'Id': widget.id.toString(),
        });
        var response = await dio.post(BASE_URL, data: formData);
        if (response.statusCode == 200) {
          print(response.data);
        }
      }
    }
  }

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: ServiceNameController,
            decoration: InputDecoration(
              labelText: 'Service Name',
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: loadAssets,
            child: const Text('Pick Image'),
          ),
          Expanded(
            child: buildGridView(),
          ),
          ElevatedButton(
            onPressed: () async {
              await _saveImage();
              //sendName();
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
