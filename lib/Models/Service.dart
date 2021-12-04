import 'dart:convert';

List<Service> serviceFromMap(String str) => List<Service>.from(json.decode(str).map((x) => Service.fromMap(x)));

String serviceToMap(List<Service> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Service {
  Service({
    this.id,
    this.serviceId,
    this.name,
    this.serviceName,
  });

  String? id;
  int? serviceId;
  String? name;
  String? serviceName;

  factory Service.fromMap(Map<String, dynamic> json) => Service(
    id: json["\u0024id"],
    serviceId: json["ServiceId"],
    name: json["name"],
    serviceName: json["ServiceName"],
  );

  Map<String, dynamic> toMap() => {
    "\u0024id": id,
    "ServiceId": serviceId,
    "name": name,
    "ServiceName": serviceName,
  };
}
