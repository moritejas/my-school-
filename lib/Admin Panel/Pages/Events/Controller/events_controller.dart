// events_controller.dart

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventController extends GetxController {
  var eventTopics = ''.obs;
  var eventDetails = ''.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  final _formKey = GlobalKey<FormState>();

  var imageBytes = Rx<Uint8List?>(null);

  final TextEditingController eventTopicController = TextEditingController();
  final TextEditingController eventDetailController = TextEditingController();

  // List of sample events
  var events = [
    {
      'date': '02 May   09:30 AM',
      'time': '09:30 AM',
      'title': 'Sleepover Night',
      'description':
          'A Sleepover Night is a great treat for kids. Many schools use such an event as the culminating activity of the school year.',
    },
    {
      'date': '02 May   09:30 AM',
      'time': '09:30 AM',
      'title': 'Sleepover Night',
      'description':
          'A Sleepover Night is a great treat for kids. Many schools use such an event as the culminating activity of the school year.',
    },
    {
      'date': '03 May   09:30 AM',
      'time': '09:30 AM',
      'title': 'Sleepover Night',
      'description':
          'A Sleepover Night is a great treat for kids. Many schools use such an event as the culminating activity of the school year.',
    },
    {
      'date': '04 May   09:30 AM',
      'time': '09:30 AM',
      'title': 'Sleepover Night',
      'description':
          'A Sleepover Night is a great treat for kids. Many schools use such an event as the culminating activity of the school year.',
    },
    {
      'date': '05 May   09:30 AM',
      'time': '09:30 AM',
      'title': 'Sleepover Night',
      'description':
          'A Sleepover Night is a great treat for kids. Many schools use such an event as the culminating activity of the school year.',
    },
    {
      'date': '06 May   09:30 AM',
      'time': '09:30 AM',
      'title': 'Sleepover Night',
      'description':
          'A Sleepover Night is a great treat for kids. Many schools use such an event as the culminating activity of the school year.',
    },
  ].obs;

  // Function to pick an image using FilePicker (for web)
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      imageBytes.value = result.files.first.bytes;
    }
  }

  // Clear the image selection
  void clearImage() {
    imageBytes.value = null;
  }

  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  void selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime.value,
    );
    if (pickedTime != null && pickedTime != selectedTime.value) {
      selectedTime.value = pickedTime;
    }
  }

  void addAndEditEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Enter Class and Subject")),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //  Event Topic
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: eventTopicController,
                          decoration: InputDecoration(
                            hintText: "Enter Event Topic",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(
                              Icons.event_available_outlined,
                              color: Colors.teal,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Event Topic';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 15),.
                      const SizedBox(width: 15),
                      //  Event Detail
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: eventDetailController,
                          decoration: InputDecoration(
                            hintText: "Enter Event Detail",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(
                              Icons.event_note_sharp,
                              color: Colors.teal,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Event detail ';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(160, 50),
                          // maximumSize: Size(200, 50),
                          elevation: 2,
                          foregroundColor: Colors.teal,
                          // backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        icon: const Icon(Icons.access_time_filled_outlined),
                        onPressed: () {
                          selectTime();
                        },
                        label: Obx(() => Text(
                              DateFormat('hh:mm a').format(DateTime(
                                  0,
                                  0,
                                  0,
                                  selectedTime.value.hour,
                                  selectedTime.value.minute)),
                              style: const TextStyle(fontSize: 15),
                            )),
                        // const Text("Select Time")
                      ),
                      const SizedBox(width: 15),
                      //  Date
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(160, 50),
                          // maximumSize: Size(200, 50),
                          elevation: 2,
                          foregroundColor: Colors.teal,
                          // backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () {
                          selectDate();
                        },
                        label: Obx(() => Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(selectedDate.value),
                              style: const TextStyle(fontSize: 15),
                            )),
                      ),
                      const SizedBox(width: 15),
                      // Upload image
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(160, 50),
                            // maximumSize: Size(200, 50),
                            elevation: 2,
                            foregroundColor: Colors.teal,
                            // backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          icon: const Icon(Icons.image_outlined),
                          onPressed: pickImage,
                          label: const Text("Upload Image")),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(110, 50),
                              elevation: 3,
                              foregroundColor: Colors.teal,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
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
                              elevation: 3,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.teal,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                eventTopics.value = eventTopicController.text;
                                eventDetails.value = eventDetailController.text;
                                print(eventTopics.value);
                                print(eventDetails.value);
                                print(
                                  // Obx(() =>
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(selectedDate.value),
                                        // style: const TextStyle(fontSize: 15),
                                      )
                                  // ),
                                );
                                print(
                                  // Obx(() =>
                                      Text(
                                        DateFormat('hh:mm a').format(DateTime(
                                            0,
                                            0,
                                            0,
                                            selectedTime.value.hour,
                                            selectedTime.value.minute)),
                                        // style: const TextStyle(fontSize: 15),
                                      )
                                // ),
                                );
                                Get.back();
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
