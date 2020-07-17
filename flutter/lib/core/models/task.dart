import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
    Task({
        this.id,
        this.name,
        this.description,
        this.categoryId,
        this.createdDate,
    });

    String id;
    String name;
    String description;
    String categoryId;
    DateTime createdDate;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        categoryId: json["categoryId"],
        createdDate: DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "categoryId": categoryId,
        "createdDate": createdDate.toIso8601String(),
    };
}