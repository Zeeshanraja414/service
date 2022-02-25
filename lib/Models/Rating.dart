// To parse this JSON data, do
//
//     final star = starFromJson(jsonString);

import 'dart:convert';

List<Star> starFromJson(String str) =>
    List<Star>.from(json.decode(str).map((x) => Star.fromJson(x)));

String starToJson(List<Star> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Star {
  Star({
    required this.id,
    required this.rid,
    required this.ohid,
    required this.uid,
    required this.rating,
  });

  String id;
  int rid;
  int ohid;
  int uid;
  var rating;

  factory Star.fromJson(Map<String, dynamic> json) => Star(
        id: json["\u0024id"],
        rid: json["Rid"],
        ohid: json["Ohid"],
        uid: json["Uid"],
        rating: json["Rating1"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "Rid": rid,
        "Ohid": ohid,
        "Uid": uid,
        "Rating1": rating,
      };
}
