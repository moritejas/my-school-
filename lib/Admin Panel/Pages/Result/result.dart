import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school_addmin/Students/Controller/student_controllers.dart';


class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  // final StudentPageController studentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      appBar: AppBar(
          title: const Text("Results"),
          centerTitle: true,
        // backgroundColor: Colors.blue,
      ),

      body: const Center(
        child: Text(" Results Data"),
      ),

    );
  }
}
