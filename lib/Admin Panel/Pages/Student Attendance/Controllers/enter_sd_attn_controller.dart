// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Model/students_get_data_model.dart';

class StudentAttendanceController extends GetxController {
  var students = <StudentsData>[].obs;
  var studentClass = <String>[].obs;
  var selectedClass = Rxn<String>();
  var selectedDate = DateTime.now().obs;
  var attendanceStatus = <String, String>{}.obs;
  var absenceReasons = <String, String>{}.obs;

  get formattedDate => null;

  @override
  void onInit() {
    super.onInit();
    loadStudentsData();
  }

  // Fetch Student data
  Future<void> loadStudentsData() async {
    try {
      String data =
          await rootBundle.loadString('assets/studentinformation.json');
      List<dynamic> jsonList = json.decode(data);
      List<StudentsData> allStudents =
          jsonList.map((e) => StudentsData.fromJson(e)).toList();
      studentClass.value = allStudents
          .map((student) => student.standard)
          .toSet()
          .cast<String>()
          .toList();
      students.value = allStudents;

      studentClass.sort((a, b) => a.compareTo(b));
      students.sort((a, b) => a.idNo.compareTo(b.idNo));
      // Initialize all students' attendance to 'present'
      for (var student in students) {
        attendanceStatus[student.idNo.toString()] = 'present';
      }
    } catch (e) {
      print('Error loading students data: $e');
    }
  }

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
    }
  }

  void markAttendance(String studentId, String status, {String? reason}) {
    attendanceStatus[studentId] = status;
    if (status == 'absent' && reason != null && reason.isNotEmpty) {
      absenceReasons[studentId] = reason;
    } else if (status == 'present') {
      absenceReasons.remove(studentId);
    }
  }

  Future<void> showAbsenceReasonDialog(
      BuildContext context, String studentId) async {
    String reason = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Absence Reason'),
          content: TextField(
            onChanged: (value) {
              reason = value;
            },
            decoration: const InputDecoration(hintText: "Reason"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                markAttendance(studentId, 'absent', reason: reason);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void submitAttendance(BuildContext context) {
    final List<String> unmarkedStudents = [];

    students
        .where((student) => student.standard == selectedClass.value)
        .forEach((student) {
      final String studentId = student.idNo.toString();
      final attendance = attendanceStatus[studentId] ?? 'not marked';
      final reason = absenceReasons[studentId];

      if (attendance == 'not marked') {
        unmarkedStudents.add('${student.fullname} (ID: $studentId)');
      }

      print(
          'Student ID: $studentId,\n Name: ${student.fullname},\n Class: $selectedClass,\n'
          'Date: ${DateFormat('dd-MM-yyyy').format(selectedDate.value)},\n Attendance: $attendance ${reason != null && reason.isNotEmpty ? ',\n Reason: $reason' : ''}');
    });

    if (unmarkedStudents.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Attendance not marked for: ${unmarkedStudents.join(', ')}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Submitted Data'),
        ),
      );
    }
  }

  void refreshScreen() {
    selectedClass.value = null;
    selectedDate.value = DateTime.now();
    attendanceStatus.clear();
    absenceReasons.clear();
    loadStudentsData();
  }
}
