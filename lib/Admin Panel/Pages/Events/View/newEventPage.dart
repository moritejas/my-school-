// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/events_controller.dart';

class EventsPage extends StatelessWidget {
  final EventController controller = Get.put(EventController());

  EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Events",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Obx(() {
                if (controller.events.isEmpty) {
                  return const Center(
                    child: Text("No Events Available"),
                  );
                }
                return SingleChildScrollView(
                  child: Wrap(
                    spacing: 10, // Horizontal space between items
                    runSpacing: 10, // Vertical space between rows
                    children: List.generate(controller.events.length, (index) {
                      final event = controller.events[index];

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width:
                              310, // You can keep this width fixed if necessary
                          // Remove the fixed height
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  event['title']!,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 250,
                                        width: 250,
                                        // Dynamically sized image container
                                        // width: double.infinity, // Will take the full width of the parent
                                        // constraints: BoxConstraints(
                                        //   maxHeight: 250, // Add constraints if you want to limit size
                                        //   minHeight: 100, // Minimum height for small content
                                        // ),
                                        decoration: BoxDecoration(
                                          // color: Colors.teal.withOpacity(0.4),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.teal, width: 5),
                                        ),
                                        child: Obx(() => controller
                                                    .imageBytes.value ==
                                                null
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.teal,
                                                        width: 5)),
                                                height: 150,
                                                width: 150,
                                                child: Image.asset(
                                                  'assets/Images/schoolEvent/school_event_image.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              )

                                            // const Center(child: Text('No image selected.'))
                                            : Image.memory(
                                                controller.imageBytes.value!,
                                                fit: BoxFit
                                                    .contain, // Fit the image to the container
                                              )),
                                      ),
                                      Positioned(
                                        bottom: 8, // Adjust position as needed
                                        right: 8, // Adjust position as needed
                                        child: GestureDetector(
                                          onTap: () {
                                            controller
                                                .pickImage(); // Trigger image picking
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.teal.withOpacity(0.7),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.upload_file,
                                              color: Colors.white,
                                              size: 24, // Adjust size as needed
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  event['date']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  event['description']!,
                                  // Wrap text to handle longer content
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add event logic here
          controller.addAndEditEvent(context);
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
