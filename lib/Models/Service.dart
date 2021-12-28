import 'dart:convert';
import 'package:http/http.dart' as http;

// List<Service> serviceFromMap(String str) => List<Service>.from(json.decode(str).map((x) => Service.fromMap(x)));
//
// String serviceToMap(List<Service> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
//
// class Service {
//   Service({
//     this.id,
//     this.serviceId,
//     this.name,
//     this.serviceName,
//   });
//
//   String? id;
//   int? serviceId;
//   String? name;
//   String? serviceName;
//
//   factory Service.fromMap(Map<String, dynamic> json) => Service(
//     id: json["\u0024id"],
//     serviceId: json["ServiceId"],
//     name: json["name"],
//     serviceName: json["ServiceName"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "\u0024id": id,
//     "ServiceId": serviceId,
//     "name": name,
//     "ServiceName": serviceName,
//   };
// }
List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    this.id,
    this.serviceId,
    this.name,
    this.serviceName,
  });

  String? id;
  int? serviceId;
  String? name;
  String? serviceName;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["\u0024id"],
        serviceId: json["ServiceId"],
        name: json["name"],
        serviceName: json["ServiceName"],
      );
}

Future<List<Post>> fetchPost() async {
  final response = await http.get(
      Uri.parse('http://192.168.10.5/OldHome1/api/oldhome/GetFlowerImages'));
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed');
  }
}
