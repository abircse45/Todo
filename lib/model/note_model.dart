// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  NoteModel({
    this.id,
    this.studentid,
    this.name,
    this.email,
    this.department,
    this.university,
    this.datetime,
  });

  int ? id;
  String ?  studentid;
  String ? name;
  String ? email;
  String ? department;
  String ? university;
  String ? datetime;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json["id"] == null ? null : json["id"],
    studentid: json["studentid"] == null ? null : json["studentid"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    department: json["department"] == null ? null : json["department"],
    university: json["university"] == null ? null : json["university"],
    datetime: json["datetime"] == null ? null : json["datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "studentid": studentid == null ? null : studentid,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "department": department == null ? null : department,
    "university": university == null ? null : university,
    "datetime": datetime == null ? null : datetime,
  };
}
