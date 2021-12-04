import 'dart:convert';
import 'package:http/http.dart'as http;

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post( {
    required this.FullName,
    required this.ContactNo,
    required this.Address,
    required this.City,
    required this.UserName,
  });
  var UserName;
  var FullName;
  var ContactNo;
  var Address;
  String City;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    UserName:json["UserName"],
    FullName: json["FullName"],
    ContactNo: json["ContactNo"],
    Address: json["Address"],
    City: json["City"],
  );
}
Future<List<Post>> fetchPost() async {
  try{
    final response = await http
        .post(Uri.parse('http://192.168.10.16/OldHome1/api/oldhome/searchbyusername?UserName=Zeeshan'));
    print(jsonDecode(response.body));
    //final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    //return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  }catch(e){
    print(e);
  }
  final response = await http
      .get(Uri.parse('http://192.168.10.16/OldHome1/api/oldhome/searchbyusername?UserName=Zeeshan'));

  final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  //return Post.PostFromJson(jsonDecode(response.body));

}
