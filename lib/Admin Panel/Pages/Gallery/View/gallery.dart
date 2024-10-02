import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _ClassState();
}

class _ClassState extends State<Gallery> {

  // final StudentPageController studentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      appBar: AppBar(
        title: const Text("Gallery"),
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),

      body: const Center(
        child: Text("Gallery Data"),
      ),

    );
  }
}
