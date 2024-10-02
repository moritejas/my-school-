import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../Model/student_attendance_get_model.dart';

class ViewStudentClassController extends GetxController {
  var students = <StudentAttendance>[].obs;
  var filteredStudentsByDate = <StudentAttendance>[].obs;
  var classes = <String>[].obs;
  var selectedMonthYear = ''.obs;
  DateTime? myMY;
  var selectedClass = ''.obs;
  var datesInMonth = <DateTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStudentsDatas();
  }

  Future<void> loadStudentsDatas() async {
    try {
      String data =
          await rootBundle.loadString('assets/add_student_attendance.json');
      List<dynamic> jsonList = json.decode(data);

      final List<StudentAttendance> allStudents =
          jsonList.map((e) => StudentAttendance.fromJson(e)).toList();

      students.value = allStudents;
      classes.value =
          students.map((student) => student.sclass).toSet().toList();
    } catch (e) {
      print('Error loading students data: $e');
      Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          'Error',
          'Failed to load student data');
    }
  }

  void onSelectedClassChanged(String newClass) {
    selectedClass.value = newClass;
  }

  void setDate(DateTime date) {
    selectedMonthYear.value = DateFormat('MM-yyyy').format(date);
    _generateDatesForMonth(date);
  }

  void _generateDatesForMonth(DateTime date) {
    int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    datesInMonth.value = List.generate(
        daysInMonth, (i) => DateTime(date.year, date.month, i + 1));
  }

  void filteredData() {
    if (myMY != null) {
      filteredStudentsByDate.value = students
          .where((student) =>
              student.sclass == selectedClass.value &&
              student.date.month == myMY!.month &&
              student.date.year == myMY!.year)
          .toList();

      filteredStudentsByDate.value = {
        for (var student in filteredStudentsByDate) student.studentId: student
      }.values.toList();
    }
  }

  void refreshScreen() {
    selectedClass.value = '';
   selectedMonthYear = ''.obs;

    filteredStudentsByDate.clear();

    datesInMonth.clear();



  }
}
