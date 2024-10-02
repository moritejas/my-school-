import 'dart:convert';

List<StudentsData> studentsDataFromJson(String str) => List<StudentsData>.from(json.decode(str).map((x) => StudentsData.fromJson(x)));

String studentsDataToJson(List<StudentsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentsData {
  String fullname;
  String standard;
  dynamic idNo;
  String gender;
  String enrollmentNumber;
  int phoneNumber;
  DateTime dateOfBirth;
  DateTime joiningDate;
  String address;

  StudentsData({
    required this.fullname,
    required this.standard,
    required this.idNo,
    required this.gender,
    required this.enrollmentNumber,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.joiningDate,
    required this.address,
  });

  factory StudentsData.fromJson(Map<String, dynamic> json) => StudentsData(
    fullname: json["fullname"],
    standard: json["class"],
    idNo: json["id_no"],
    gender: json["gender"],
    enrollmentNumber: json["enrollment_number"],
    phoneNumber: json["phone_number"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    joiningDate: DateTime.parse(json["joining_date"]),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "class": standard,
    "id_no": idNo,
    "gender": gender,
    "enrollment_number": enrollmentNumber,
    "phone_number": phoneNumber,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "joining_date": "${joiningDate.year.toString().padLeft(4, '0')}-${joiningDate.month.toString().padLeft(2, '0')}-${joiningDate.day.toString().padLeft(2, '0')}",
    "address": address,
  };
}
