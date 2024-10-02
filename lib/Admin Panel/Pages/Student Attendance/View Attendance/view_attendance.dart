// ignore_for_file: avoid_print, unnecessary_to_list_in_spreads

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controllers/view_attendance_controller.dart';
// import 'package:school_addmin/Admin%20Panel/Pages/Student%20Attendance/Controllers/view_attendance_controller.dart';

class ViewAttendanceFirsts extends StatefulWidget {
  const ViewAttendanceFirsts({super.key});

  @override
  State<ViewAttendanceFirsts> createState() => _ViewAttendanceFirstsState();
}

final ViewStudentClassController controller =
    Get.put(ViewStudentClassController());

class _ViewAttendanceFirstsState extends State<ViewAttendanceFirsts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  AppBar
      appBar: AppBar(
        title: const Text('View Student Attendance',style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.teal,
        actions: [
          Row(
            children: [
              //Icon(Icons.search),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed:
                    // () {
                    controller.refreshScreen,
                // controller.loadStudentsDatas();
                // },
              ),
            ],
          ),
        ],
        centerTitle: true,
        // backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 4.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Obx(() {
                    return DropdownButton<String>(
                      hint: const Text(
                        "SC",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                      value: controller.selectedClass.value.isEmpty
                          ? null
                          : controller.selectedClass.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.selectedClass.value = newValue;
                          controller.onSelectedClassChanged(newValue);
                          print(controller.selectedClass.value);
                        }
                      },
                      icon:
                          const Icon(Icons.arrow_downward, color: Colors.teal),
                      iconSize: 20,
                      elevation: 10,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      underline: const SizedBox.shrink(),
                      items: controller.classes
                          .map<DropdownMenuItem<String>>((String classname) {
                        return DropdownMenuItem<String>(
                          value: classname,
                          child: Text(
                            classname,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 4.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.teal,
                      minimumSize: const Size(150, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          // ignore: sized_box_for_whitespace
                          return Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    3,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.monthYear,
                              initialDateTime: DateTime.now(),
                              maximumDate: DateTime.now(),
                              minimumYear: 2000,
                              onDateTimeChanged: (DateTime newDate) {
                                controller.myMY = newDate;
                                controller.setDate(newDate);
                                controller.filteredData();
                              },
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.teal,
                    ),
                    label: Obx(() => Text(
                          controller.selectedMonthYear.value,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.teal),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.selectedClass.value.isEmpty) {
                  return const Center(child: Text('Please select a class.'));
                }

                if (controller.filteredStudentsByDate.isEmpty) {
                  return const Center(
                      child: Text('No students found for this class.'));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    // child: Card(
                    //   shadowColor: Colors.grey,
                    //   elevation: 3  ,
                    // color: Colors.white54,
                    child: Card(
                      shadowColor: Colors.grey,
                      elevation: 3,
                      // color: Colors.white54,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal, width: 4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Colors.white60; // Color when hovered
                            }
                            return Colors.white60; // Default color
                          }),

                          columnSpacing: 20,
                          // dividerThickness: 0,

                          columns: [
                            const DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label:
                                  Text(
                                'ID',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                    fontSize: 18),
                              ),
                            ),
                            const DataColumn(
                                // headingRowAlignment: MainAxisAlignment.center,
                                label:
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                      fontSize: 18),
                                ),
                                ),
                            ...controller.datesInMonth.map((date) => DataColumn(
                                  tooltip: "Date",
                                  label:

                                      Text(
                                    DateFormat('dd').format(date),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.teal,
                                    ),
                                  ),
                                )),
                          ],
                          rows:
                          controller.filteredStudentsByDate.map((student) {
                            return DataRow(
                              // color: MaterialStateProperty.all(Colors.blueGrey),
                              cells: [
                                DataCell(
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: CircleAvatar(
                                      // foregroundColor: Colors.red,
                                      backgroundColor: const Color(0xFFAFDEDC),
                                      child: Text(
                                        student.studentId.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      // Text(studentId.toString())
                                    ),
                                  ),

                                ),
                                DataCell(

                                    Text(
                                      student.name,
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //     // color: Colors.teal
                                      //   ),
                                    ),
                                ),
                                ...controller.datesInMonth.map((date) {
                                  String attendance = controller.students
                                          .firstWhereOrNull((s) =>
                                              s.studentId ==
                                                  student.studentId &&
                                              s.date == date)
                                          ?.attendance ??
                                      'N/A';

                                  IconData attendanceIcon;
                                  Color iconColor;

                                  if (attendance == 'Present') {
                                    attendanceIcon = Icons.check;
                                    iconColor = Colors.green;
                                  } else if (attendance == 'Absent') {
                                    attendanceIcon = Icons.close;
                                    iconColor = Colors.red;
                                  } else {
                                    attendanceIcon = Icons.help_outline;
                                    iconColor = Colors.orange;
                                  }

                                  return DataCell(Icon(
                                    attendanceIcon,
                                    color: iconColor,
                                  )
                                      // Text(attendance)
                                      );
                                }).toList(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
