import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController {
  var isLoading = false.obs; // To indicate loading state.
  // var subjects = <Map<String, String>>[].obs; // List to hold class and subject data.

  // Method to add class and subject
  void addAndEditClassSubject(BuildContext context) {
    final TextEditingController classController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Class and Subject"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: classController,
                decoration: InputDecoration(
                  hintText: "Enter Class",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(
                    Icons.class_,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  hintText: "Enter Subject",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(
                    Icons.book,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        elevation: 8,
                        foregroundColor: Colors.teal,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        elevation: 8,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      onPressed: () {
                        if (classController.text.isNotEmpty &&
                            subjectController.text.isNotEmpty) {
                          // Add the entered class and subject to the list
                          // subjects.add({
                          //   'class': classController.text,
                          //   'subject': subjectController.text,
                          // });
                          Get.back(); // Close dialog after submission
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to delete an item
  void deleteItem(int index) {
    // subjects.removeAt(index); // Remove item from the list
  }
}
