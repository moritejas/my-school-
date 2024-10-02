// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Model/timeTable_model_class.dart';


class TimeTableController extends GetxController {
  var timeTables = <TimeTable>[].obs;
  var allTimeTables = <TimeTable>[].obs;
  // Observable list of days
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ].obs;
  var classList = <String>['8', '9', '10A', '10B', '11A', '11B', '12A', '12B',].obs;
  // Observable variable for the selected day
  var selectedDay = ''.obs;
  var selectedTime = TimeOfDay.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadStudentsDatas();
  }

  // Function to update the selected day
  void updateDays(String day) {
    selectedDay.value = day;
  }

  // Time
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (pickedTime != null && pickedTime != selectedTime.value) {
      selectedTime.value = pickedTime;
    }
  }

  // Get Data
  Future<void> loadStudentsDatas() async {
    try {
      String data = await rootBundle.loadString('assets/newtimetable.json');
      List<dynamic> jsonList = json.decode(data);

      allTimeTables.value = jsonList.map((e) => TimeTable.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data');
    }
  }


  // Future<void> loadStudentsData() async {
  //   try {
  //     String data = await rootBundle.loadString('assets/homework.json');
  //     List<dynamic> jsonList = json.decode(data);
  //
  //     homework.value = jsonList.map((e) => Homework.fromJson(e)).toList();
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load data');
  //   }
  // }

  // Update Day
  void updateDay(int tableIndex, String dayName, Day updatedDay, int dayIndex) {
    // Create a copy of the current table
    TimeTable currentTable = allTimeTables[tableIndex];

    // Determine which day list to update
    switch (dayName) {
      case "Monday":
        currentTable.monday[dayIndex] = updatedDay;
        break;
      case "Tuesday":
        currentTable.tuesday[dayIndex] = updatedDay;
        break;
      case "Wednesday":
        currentTable.wednesday[dayIndex] = updatedDay;
        break;
      case "Thursday":
        currentTable.thursday[dayIndex] = updatedDay;
        break;
      case "Friday":
        currentTable.friday[dayIndex] = updatedDay;
        break;
      case "Saturday":
        currentTable.saturday[dayIndex] = updatedDay;
        break;
    }

    // Update the list with the modified table
    allTimeTables[tableIndex] = currentTable;
  }

  // Delete Day
  void deleteDay(int tableIndex, String dayName, int dayIndex) {
    TimeTable currentTable = allTimeTables[tableIndex];

    // Determine which day list to remove the entry from
    switch (dayName) {
      case "Monday":
        currentTable.monday.removeAt(dayIndex);
        break;
      case "Tuesday":
        currentTable.tuesday.removeAt(dayIndex);
        break;
      case "Wednesday":
        currentTable.wednesday.removeAt(dayIndex);
        break;
      case "Thursday":
        currentTable.thursday.removeAt(dayIndex);
        break;
      case "Friday":
        currentTable.friday.removeAt(dayIndex);
        break;
      case "Saturday":
        currentTable.saturday.removeAt(dayIndex);
        break;
    }

    // Update the list with the modified table
    allTimeTables[tableIndex] = currentTable;

    // Optional: Save changes to persistent storage or remote database here
  }

  // Add new timetable entry
  void addNewTimetableEntry(String selectedDay, Day newDay) {
    if (allTimeTables.isNotEmpty) {
      TimeTable currentTable = allTimeTables.first;

      switch (selectedDay) {
        case "Monday":
          currentTable.monday.add(newDay);
          break;
        case "Tuesday":
          currentTable.tuesday.add(newDay);
          break;
        case "Wednesday":
          currentTable.wednesday.add(newDay);
          break;
        case "Thursday":
          currentTable.thursday.add(newDay);
          break;
        case "Friday":
          currentTable.friday.add(newDay);
          break;
        case "Saturday":
          currentTable.saturday.add(newDay);
          break;
      }

      // Trigger UI update by setting the updated table back to observable
      allTimeTables[0] = currentTable;
    }
  }

  void showEditDialog(BuildContext context, Day day, String dayName,
      int tableIndex, int dayIndex) {
    final TextEditingController subjectController =
    TextEditingController(text: day.subject);
    final TextEditingController timeController =
    TextEditingController(text: day.time);
    final TextEditingController teacherController =
    TextEditingController(text: day.teacher);
    final TextEditingController typeController =
    TextEditingController(text: day.type);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $dayName Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
              TextField(
                controller: teacherController,
                decoration: const InputDecoration(labelText: 'Teacher'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedDay = Day(
                  subject: subjectController.text,
                  time: timeController.text,
                  teacher: teacherController.text,
                  type: typeController.text,
                );

                print(
                    "Updating day: $updatedDay at index $dayIndex"); // Debugging line

                updateDay(tableIndex, dayName, updatedDay, dayIndex);
                Get.back(); // Close the dialog
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
