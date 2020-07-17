//get and parse all categories

import 'dart:convert';

List<CategoryList> categoriListFromJson(String str) => List<CategoryList>.from(
    json.decode(str).map((x) => CategoryList.fromJson(x)));

String categoriListToJson(List<CategoryList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryList {
  CategoryList({
    this.id,
    this.name,
    this.createdDate,
  });

  String id;
  String name;
  DateTime createdDate;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
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
