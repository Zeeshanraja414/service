// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
// //import 'package:old/config.dart';
//
// class Multiimage extends StatefulWidget {
//   const Multiimage({Key? key}) : super(key: key);
//
//   @override
//   _MultiimageState createState() => _MultiimageState();
// }
//
// class _MultiimageState extends State<Multiimage> {
//   List<Asset> images = [];
//    Dio dio = Dio();
//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 3,
//       children: List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         );
//       }),
//     );
//   }
//   Future<void> loadAssets() async {
//     List<Asset> resultList = [];
//
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 300,
//         enableCamera: true,
//         selectedAssets: images,
//         cupertinoOptions: const CupertinoOptions(
//           takePhotoIcon: "chat",
//           doneButtonTitle: "Fatto",
//         ),
//         materialOptions: const MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       print(e.toString());
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       images = resultList;
//     });
//   }
//   static const BASE_URL="http://192.168.10.3/OldHome1/api/oldhome/uploadfiles";
//   _saveImage() async{
//     if(images != null) {
//       for (var i = 0; i < images.length; i++) {
//         ByteData byteData = await images[i].getByteData();
//         List<int> imageData = byteData.buffer.asInt8List();
//
//         MultipartFile multipartFile = MultipartFile.fromBytes(
//           imageData,
//           filename: images[i].name,
//           contentType: MediaType('image', 'jpg'),
//         );
//         FormData formData = FormData.fromMap({
//           "Image": multipartFile,
//         });
//         var response = await dio.post(BASE_URL, data: formData);
//         if(response.statusCode==200){
//           print(response.data);
//
//         }
//   }
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upload Image'),),
//       body: Column(
//         children: [
//           ElevatedButton(onPressed:loadAssets,
//           child: const Text('Pick Image'),
//           ),
//           Expanded(
//             child: buildGridView(),
//              ),
//           ElevatedButton(onPressed:_saveImage,
//             child: const Text('Save'),
//           )
//         ],
//       ),
//     );
//   }
// }
