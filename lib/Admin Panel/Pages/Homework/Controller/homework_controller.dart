import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school/Admin%20Panel/Model/homework_model.dart';

class HomeworkController extends GetxController {
  var allHomework = <Homework>[].obs;
  var filteredAllHomework = <Homework>[].obs;
  var hClass = <String>[].obs;
  var selectedHClass = ''.obs;
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    getHomework();
  }

  Future<void> getHomework() async {
    try {
      String data = await rootBundle.loadString('assets/homework.json');
      List<dynamic> jsonList = json.decode(data);
      List<Homework> homeworks =
          jsonList.map((e) => Homework.fromJson(e)).toList();

      allHomework.value = homeworks;

      hClass.value = allHomework.map((hw) => hw.hwclass).toSet().toList();
      print(hClass);
    } catch (e) {

      print(e);
    }
  }

  void onSelectedClassChanged(String newClass) {
    selectedHClass.value = newClass;
  }

//  DateFormat('dd - MM - yyyy')
//                             .format(controller.selectedDate.value),
  // Select Date
  Future<void> userSelectedDate(BuildContext context) async {
    final DateTime? userDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDate: selectedDate.value,
    );
    if (userDate != null && userDate != selectedDate.value) {
      selectedDate.value = userDate;
      print(selectedDate.value);
      genrateFilterData();
    }
  }

  void genrateFilterData() {
    if (selectedHClass.isNotEmpty) {
      // Use the correct format for your JSON dates (dd-MM-yyyy)
      final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

      // Filter homework by class and date
      filteredAllHomework.value = allHomework.where((hworks) {
        DateTime homeworkDate;

        try {
          // Parse the homework date using the correct format
          homeworkDate = dateFormat.parse(hworks.date);
        } catch (e) {
          print('Date parsing error: $e');
          return false; // Skip this entry if the date cannot be parsed
        }

        // Compare the selected class and the parsed date
        return hworks.hwclass == selectedHClass.value &&
            homeworkDate.year == selectedDate.value.year &&
            homeworkDate.month == selectedDate.value.month &&
            homeworkDate.day == selectedDate.value.day;
      }).toList();

      // Debugging: print filtered homework data
      print('Filtered Homework: ${filteredAllHomework.length}');
    }
  }
}
