// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  TodoModel({
    this.id,
    this.title,
    this.description,
    this.dateTime,
  });

  int  ?id;
  String? title;
  String ?description;
  String ?dateTime;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    dateTime: json["dateTime"] == null ? null : json["dateTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "dateTime": dateTime == null ? null : dateTime,
  };
}
