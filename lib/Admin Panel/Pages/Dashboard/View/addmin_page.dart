import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school/Admin%20Panel/Pages/Students/View/new_student_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // final AdminController adminController = Get.find();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      appBar: AppBar(
        title: const Text("Addmin"),
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            ElevatedButton(
              onPressed: (){

              Get.to(const StudentsPages());
            },
                child: const Text('Students'),),

              ],
            ),
          ),
        // ),
      ),

    );
  }
}

