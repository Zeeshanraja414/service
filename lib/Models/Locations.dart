// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

List<Location> locationFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  Location({
    required this.id,
    required this.locationId,
    required this.fullName,
    required this.contactNo,
    required this.email,
    required this.address,
    required this.userName,
    required this.password,
    required this.userType,
    required this.city,
    required this.vacantSeats,
    required this.gender,
    required this.totalSeats,
  });

  String id;
  int locationId;
  String fullName;
  String contactNo;
  String email;
  String address;
  String userName;
  String password;
  String userType;
  String city;
  String vacantSeats;
  String gender;
  String totalSeats;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["\u0024id"],
        locationId: json["Id"],
        fullName: json["FullName"],
        contactNo: json["ContactNo"],
        email: json["Email"],
        address: json["Address"],
        userName: json["UserName"],
        password: json["Password"],
        userType: json["UserType"],
        city: json["City"],
        vacantSeats: json["VacantSeats"],
        gender: json["Gender"],
        totalSeats: json["TotalSeats"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "Id": locationId,
        "FullName": fullName,
        "ContactNo": contactNo,
        "Email": email,
        "Address": address,
        "UserName": userName,
        "Password": password,
        "UserType": userType,
        "City": city,
        "VacantSeats": vacantSeats,
        "Gender": gender,
        "TotalSeats": totalSeats,
      };
}
