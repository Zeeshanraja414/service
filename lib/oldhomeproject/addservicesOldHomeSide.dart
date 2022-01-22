import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  var image;
  TextEditingController ServiceNameController = TextEditingController();

  //Object? _value = 'user';
  late bool error, sending, success;
  late String msg;
  String url = "http://${IpAdress.ip}/OldHome1/api/oldhome/addservice";

  Future<void> sendName() async {
    var res = await http.post(Uri.parse(url), body: {
      'ServiceName': ServiceNameController.text,
      'Id': widget.id.toString(),
      'name': image,
    });
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
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

  // String BASE_URL = "http://${IpAdress.ip}/OldHome1/api/oldhome/Image?s=${ServiceNameController.text}&i=${widget.id}";

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
        var response = await dio.post(
            "http://${IpAdress.ip}/OldHome1/api/oldhome/Image?s=${ServiceNameController.text}&i=${widget.id}",
            data: formData);
        if (response.statusCode == 200) {
          print("picture" + response.data);
          image = response.data;
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
        title: const Text('ADD SERVICES'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: ServiceNameController,
              decoration: InputDecoration(
                labelText: 'Service Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: loadAssets,
              child: const Text('Pick Image'),
            ),
            Expanded(
              child: buildGridView(),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  var c = ServiceNameController.text;
                  await _saveImage();
                  //print(ServiceNameController);
                  //sendName();
                  setState(() {
                    showAlertDialog(context);
                  });
                },
                child: const Text('Save'),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       print(images);
            //     },
            //     child: Text('Print')),
          ],
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
    title: Text("Services Add Successfully"),
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
