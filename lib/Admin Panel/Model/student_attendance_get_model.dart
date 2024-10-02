import 'dart:convert';

import 'package:intl/intl.dart';

List<StudentAttendance> studentAttendanceFromJson(String str) => List<StudentAttendance>.from(json.decode(str).map((x) => StudentAttendance.fromJson(x)));

String studentAttendanceToJson(List<StudentAttendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentAttendance {
  String sclass;
  DateTime date;
  int studentId;
  String name;
  String attendance;
  String reason;

  StudentAttendance({
    required this.sclass,
    required this.date,
    required this.studentId,
    required this.name,
    required this.attendance,
    required this.reason,
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return
      StudentAttendance(
    sclass: json["class"],

    date: dateFormat.parse(json["date"],),

    studentId: int.parse(json["student_id"].toString()),
    name: json["name"],
    attendance: json["attendance"],
    reason: json["reason"],
  );
  }

  Map<String, dynamic> toJson() => {
    "class": sclass,
    "date": date,
    "student_id": studentId,
    "name": name,
    "attendance": attendance,
    "reason": reason,
  };
}
