import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controllers/enter_sd_attn_controller.dart';

class EnterStudentAttendance extends StatelessWidget {
  final StudentAttendanceController controller =
      Get.put(StudentAttendanceController());

  EnterStudentAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  AppBar
      appBar: AppBar(
        title: const Text(
          'Students Attendance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: [
          Row(
            children: [
              //Icon(Icons.search),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed:
                    // controller.loadStudentsData();
                    controller.refreshScreen,
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // showSearchDialog(context);
                },
              ),
            ],
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Select Class
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 4.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Obx(() {
                    return DropdownButton<String>(
                      hint: const Text(
                        "Select Class",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                      value: controller.selectedClass.value,
                      onChanged: (String? newValue) {
                        controller.selectedClass.value = newValue!;
                      },
                      icon:
                          const Icon(Icons.arrow_downward, color: Colors.teal),
                      iconSize: 20,
                      elevation: 10,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      underline: const SizedBox.shrink(),
                      items: controller.studentClass
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            'Standard $value',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),

                const SizedBox(width: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.teal,
                    minimumSize: const Size(140, 60),
                    backgroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => controller.userSelectedDate(context),
                  child: Text(
                    DateFormat('dd - MM - yyyy')
                        .format(controller.selectedDate.value),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Show Select Date and Class
            /*
            Obx(() {
              return controller.selectedClass.value != null
                  ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Class: ${controller.selectedClass.value}',
                    style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 50,),
                  Text(
                    'Date: ${DateFormat('dd-MM-yyyy').format(controller.selectedDate.value)}',
                    style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ],
              )
                  : const SizedBox.shrink();
            }),
            const SizedBox(height: 10),
            */
            Obx(() {
              return controller.selectedClass.value == null
                  ? const Center(
                      child: Text(
                      'Please select Class and Date',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ))
                  : Expanded(
                      child: ListView(
                        children: controller.students
                            .where((student) =>
                                student.standard ==
                                controller.selectedClass.value)

                            .map((student) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        // ID
                                        CircleAvatar(
                                          child: Text(student.idNo.toString()),
                                        ),
                                        const SizedBox(width: 20),
                                        // Name
                                        const Icon(Icons.person_outlined),
                                        Text(student.fullname),
                                        const SizedBox(width: 20),
                                        // Present
                                        const Icon(Icons.date_range),
                                        const SizedBox(width: 10),
                                        const Text("Present"),
                                        Obx(() {
                                          return Radio<String>(
                                            value: 'present',
                                            groupValue:
                                                controller.attendanceStatus[
                                                    student.idNo.toString()],
                                            onChanged: (String? value) {
                                              controller.markAttendance(
                                                  student.idNo.toString(),
                                                  'present');
                                            },
                                          );
                                        }),
                                        const SizedBox(width: 10),
                                        // Absent
                                        const Text("Absent"),
                                        Obx(() {
                                          return Radio<String>(
                                            value: 'absent',
                                            groupValue:
                                                controller.attendanceStatus[
                                                    student.idNo.toString()],
                                            onChanged: (String? value) {
                                              controller
                                                  .showAbsenceReasonDialog(
                                                      context,
                                                      student.idNo.toString());
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    );
            }),
            // const SizedBox(height: 100,),
            Obx(() {
              return controller.selectedClass.value != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.teal,
                            minimumSize: const Size(400, 50),
                            backgroundColor: Colors.white70,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => controller.submitAttendance(context),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
