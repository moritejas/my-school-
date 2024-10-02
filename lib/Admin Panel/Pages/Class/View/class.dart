// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../Controller/view_class_controller.dart';

class Classed extends StatefulWidget {
  const Classed({super.key});

  @override
  State<Classed> createState() => _ClassedState();
}

class _ClassedState extends State<Classed> {
  final ViewClassController controller = Get.put(ViewClassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Class",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Center(
                child: Obx(() {
                  // Show loading indicator if the class list is empty
                  if (controller.classes.isEmpty) {
                    return const CircularProgressIndicator();
                  }

                  // Display the list of classes horizontally without scrolling
                  return Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(controller.classes.length, (index) {
                      return Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          width: 155,
                          height: 175,
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: Text(
                                    controller.classes[index],
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/svg/man-com.svg',
                                          width:
                                              25, // Adjust icon size as needed
                                          height: 25,
                                          color: Colors.indigoAccent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "45",
                                          style: TextStyle(
                                            fontSize: 20,
                                            // color: Colors.teal
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/svg/woman-svgrepo-com.svg',
                                          width:
                                              25, // Adjust icon size as needed
                                          height: 25,
                                          color: Colors.indigoAccent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "65",
                                          style: TextStyle(
                                            fontSize: 20,
                                            // color: Colors.teal
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon:
                                          const Icon(Icons.edit_calendar_sharp),
                                      color: Colors.blue,
                                      onPressed: () {
                                        // Edit Class
                                        _showClassDialog(
                                            className:
                                                controller.classes[index]);
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () {
                                          // Delete Class
                                          controller.classes.removeAt(index);
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showClassDialog();
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  void _showClassDialog({String? className}) {
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _controller =
        TextEditingController(text: className);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(className == null ? 'Add New Class' : 'Edit Class'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter class name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newClassName = _controller.text;
                if (newClassName.isNotEmpty) {
                  if (className == null) {
                    // Add new class
                    controller.classes.add(newClassName);
                  } else {
                    // Edit existing class
                    int index = controller.classes.indexOf(className);
                    if (index != -1) {
                      controller.classes[index] = newClassName;
                    }
                  }
                  // Optionally, save changes to a database or API here
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
