//get and parse all categories

import 'dart:convert';

List<CategoriList> categoriListFromJson(String str) => List<CategoriList>.from(
    json.decode(str).map((x) => CategoriList.fromJson(x)));

String categoriListToJson(List<CategoriList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriList {
  CategoriList({
    this.id,
    this.name,
    this.createdDate,
  });

  String id;
  String name;
  DateTime createdDate;

  factory CategoriList.fromJson(Map<String, dynamic> json) => CategoriList(
        id: json["_id"],
        name: json["name"],
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdDate": createdDate.toIso8601String(),
      };
}
