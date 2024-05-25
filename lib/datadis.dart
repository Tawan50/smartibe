import 'dart:convert';

List<Datadis> datadisFromJson(String str) =>
    List<Datadis>.from(json.decode(str).map((x) => Datadis.fromJson(x)));

String datadisToJson(List<Datadis> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Datadis {
  Datadis({
    this.timestamp,
    this.uuid,
    this.distance,
  });

  String? timestamp;
  String? uuid;
  String? distance;

  factory Datadis.fromJson(Map<String, dynamic> json) => Datadis(
        timestamp: json["timestamp"],
        uuid: json["uuid"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "uuid": uuid,
        "distance": distance,
      };
}
