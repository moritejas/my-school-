// ignore_for_file: file_names

import 'dart:convert';

List<TimeTable> timeTableFromJson(String str) =>
    List<TimeTable>.from(json.decode(str).map((x) => TimeTable.fromJson(x)));

String timeTableToJson(List<TimeTable> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeTable {
  List<Day> monday;
  List<Day> tuesday;
  List<Day> wednesday;
  List<Day> thursday;
  List<Day> friday;
  List<Day> saturday;

  TimeTable({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  factory TimeTable.fromJson(Map<String, dynamic> json) => TimeTable(
        monday: List<Day>.from(json["Monday"].map((x) => Day.fromJson(x))),
        tuesday: List<Day>.from(json["Tuesday"].map((x) => Day.fromJson(x))),
        wednesday:
            List<Day>.from(json["Wednesday"].map((x) => Day.fromJson(x))),
        thursday: List<Day>.from(json["Thursday"].map((x) => Day.fromJson(x))),
        friday: List<Day>.from(json["Friday"].map((x) => Day.fromJson(x))),
        saturday: List<Day>.from(json["Saturday"].map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Monday": List<dynamic>.from(monday.map((x) => x.toJson())),
        "Tuesday": List<dynamic>.from(tuesday.map((x) => x.toJson())),
        "Wednesday": List<dynamic>.from(wednesday.map((x) => x.toJson())),
        "Thursday": List<dynamic>.from(thursday.map((x) => x.toJson())),
        "Friday": List<dynamic>.from(friday.map((x) => x.toJson())),
        "Saturday": List<dynamic>.from(saturday.map((x) => x.toJson())),
      };
}

class Day {
  String subject;
  String time;
  String teacher;
  String type;

  Day({
    required this.subject,
    required this.time,
    required this.teacher,
    required this.type,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        subject: json["subject"],
        time: json["time"],
        teacher: json["teacher"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "time": time,
        "teacher": teacher,
        "type": type,
      };
}
