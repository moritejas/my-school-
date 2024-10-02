import 'dart:convert';

Classes classesFromJson(String str) => Classes.fromJson(json.decode(str));

String classesToJson(Classes data) => json.encode(data.toJson());

class Classes {
  List<String> classes;

  Classes({
    required this.classes,
  });

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
    classes: List<String>.from(json["classes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "classes": List<dynamic>.from(classes.map((x) => x)),
  };
}
