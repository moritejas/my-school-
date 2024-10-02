import 'package:flutter/material.dart';
import '../Enter Student Attendance/enter_student_attendance.dart';
import '../View Attendance/view_attendance.dart';

class StudentAttendance extends StatelessWidget {
  const StudentAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          bottom: const TabBar(
            unselectedLabelStyle:TextStyle(fontWeight:FontWeight.normal,) ,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black,
            // dividerColor: Colors.red,
            labelStyle: TextStyle(fontWeight:FontWeight.bold,
                color: Colors.teal),
            // indicatorColor:Colors.lightGreenAccent,

            tabs: [
              Tab(text: 'Enter Student Attendance',),
              Tab(text: 'View Student Attendance'),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            EnterStudentAttendance(),
            const ViewAttendanceFirsts(),
          ],
        ),
      ),
    );
  }
}