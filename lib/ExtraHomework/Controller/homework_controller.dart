// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:my_school/Admin%20Panel/Model/new_homework_model.dart';
// // import 'homework_model.dart';  // Assume this is the model file you created
//
// class HomeworkController extends GetxController {
//   var selectedClass = ''.obs;
//   var selectedDate = ''.obs;
//   var homeworkData = HomeworkData(homeworkByClass: {}).obs; // For storing loaded data
//   var filteredHomework = <ClassHomework>[].obs; // For storing filtered homework
//
//   // Load data from JSON
//   Future<void> loadHomeworkData() async {
//     try {
//       String data = await rootBundle.loadString('assets/homework.json');
//       Map<String, dynamic> jsonMap = json.decode(data);
//       homeworkData.value = HomeworkData.fromJson(jsonMap);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load data');
//     }
//   }
//
//   // Filter homework based on selected class and date
//   void filterHomework() {
//     if (selectedClass.value.isNotEmpty && selectedDate.value.isNotEmpty) {
//       filteredHomework.value = homeworkData.value.homeworkByClass[selectedClass.value]?.where((homework) {
//         return homework.date == selectedDate.value;
//       }).toList() ?? [];
//     }
//   }
// }
