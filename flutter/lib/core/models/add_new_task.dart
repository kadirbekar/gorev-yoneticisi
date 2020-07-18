class NewTask {
  final String name;
  final String description;
  final String categoryId;

  NewTask({this.name, this.description, this.categoryId});

  factory NewTask.fromJson(Map<String, dynamic> json) => NewTask(
        name: json['name'],
        description: json['description'],
        categoryId: json['categoryId'],
      );

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'categoryId': categoryId};
}
