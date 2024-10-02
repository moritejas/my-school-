// class ClassHomework {
//   final String subject;
//   final String date;
//   final String homework;
//
//   ClassHomework({
//     required this.subject,
//     required this.date,
//     required this.homework,
//   });
//
//   // Factory method to create a ClassHomework instance from JSON
//   factory ClassHomework.fromJson(Map<String, dynamic> json) {
//     return ClassHomework(
//       subject: json['subject'] as String,
//       date: json['date'] as String,
//       homework: json['homework'] as String,
//     );
//   }
//
//   // Method to convert ClassHomework instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'subject': subject,
//       'date': date,
//       'homework': homework,
//     };
//   }
// }
//
// class HomeworkData {
//   final Map<String, List<ClassHomework>> homeworkByClass;
//
//   HomeworkData({
//     required this.homeworkByClass,
//   });
//
//   // Factory method to create HomeworkData instance from JSON
//   factory HomeworkData.fromJson(Map<String, dynamic> json) {
//     Map<String, List<ClassHomework>> parsedHomeworkByClass = {};
//     json.forEach((key, value) {
//       List<ClassHomework> homeworkList = (value as List)
//           .map((item) => ClassHomework.fromJson(item as Map<String, dynamic>))
//           .toList();
//       parsedHomeworkByClass[key] = homeworkList;
//     });
//     return HomeworkData(homeworkByClass: parsedHomeworkByClass);
//   }
//
//   // Method to convert HomeworkData instance to JSON
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> jsonData = {};
//     homeworkByClass.forEach((key, value) {
//       jsonData[key] = value.map((item) => item.toJson()).toList();
//     });
//     return jsonData;
//   }
// }
