// To parse this JSON data, do
//
//     final homework = homeworkFromJson(jsonString);

import 'dart:convert';

List<Homework> homeworkFromJson(String str) => List<Homework>.from(json.decode(str).map((x) => Homework.fromJson(x)));

String homeworkToJson(List<Homework> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class   Homework {
  String hwclass;
  String subject;
  String date;
  String homework;

  Homework({
    required this.hwclass,
    required this.subject,
    required this.date,
    required this.homework,
  });

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
    hwclass: json["class"],
    subject: json["subject"],
    date: json["date"],
    homework: json["homework"],
  );

  Map<String, dynamic> toJson() => {
    "class": hwclass,
    "subject": subject,
    "date": date,
    "homework": homework,
  };
}
