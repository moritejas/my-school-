

import 'dart:convert';

Classes classesFromJson(String str) => Classes.fromJson(json.decode(str));

String classesToJson(Classes data) => json.encode(data.toJson());

    class Classes {
      List<String> class10;
      List<String> class9;
      List<String> class8;
      List<String> class7;

    Classes({
      required this.class10,
      required this.class9,
      required this.class8,
      required this.class7,
    });

    factory Classes.fromJson(Map<String, dynamic> json) => Classes(
      class10: List<String>.from(json["class10"].map((x) => x)),
      class9: List<String>.from(json["class9"].map((x) => x)),
      class8: List<String>.from(json["class8"].map((x) => x)),
      class7: List<String>.from(json["class7"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
      "class10": List<dynamic>.from(class10.map((x) => x)),
      "class9": List<dynamic>.from(class9.map((x) => x)),
      "class8": List<dynamic>.from(class8.map((x) => x)),
      "class7": List<dynamic>.from(class7.map((x) => x)),
    };
}
