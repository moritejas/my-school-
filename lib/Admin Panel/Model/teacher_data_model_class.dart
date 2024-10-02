import 'dart:convert';
List<TeachersData> teachersDataFromJson(String str) => List<TeachersData>.from(json.decode(str).map((x) => TeachersData.fromJson(x)));

String teachersDataToJson(List<TeachersData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeachersData {
  String fullname;
  String subjects;
  int idNo;
  String gender;
  String email;
  int phoneNumber;
  DateTime dateOfBirth;
  DateTime joiningDate;
  String address;

  TeachersData({
    required this.fullname,
    required this.subjects,
    required this.idNo,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.joiningDate,
    required this.address,
  });

  factory TeachersData.fromJson(Map<String, dynamic> json) => TeachersData(
    fullname: json["fullname"],
    subjects: json["subjects"],
    idNo: json["id_no"],
    gender: json["gender"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    joiningDate: DateTime.parse(json["joining_date"]),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "subjects": subjects,
    "id_no": idNo,
    "gender": gender,
    "email": email,
    "phone_number": phoneNumber,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "joining_date": "${joiningDate.year.toString().padLeft(4, '0')}-${joiningDate.month.toString().padLeft(2, '0')}-${joiningDate.day.toString().padLeft(2, '0')}",
    "address": address,
  };
}
