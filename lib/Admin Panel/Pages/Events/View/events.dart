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
          // event['title']!,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        // child: SingleChildScrollView(
        child: Column(
          children: [
            //  Show Data
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.events.length,
                  itemBuilder: (context, index) {
                    final event = controller.events[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onLongPress: (){
                          controller.addAndEditEvent(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            children: [
                              //  Event Image
                              // Event Image
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Stack(
                                  alignment: Alignment.center, // Center the icon in the stack
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.teal[300],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.teal, width: 5),
                                      ),
                                      height: 200,
                                      width: 200,
                                      // child: Obx(() => controller.imageBytes.value == null
                                      //     ? const Center(child: Text('No image selected.'))
                                      //     : ClipRRect(
                                      //   borderRadius: BorderRadius.circular(8), // Match the container's border radius
                                      //   child: Image.memory(
                                      //     controller.imageBytes.value!,
                                      //     fit: BoxFit.cover, // Use BoxFit.cover to fill the container
                                      //     height: 150,
                                      //     width: 150,
                                      //   ),
                                      // )),
                                      // /*
                                      child: Obx(() => controller.imageBytes.value == null
                                          ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.teal[300],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.teal,
                                                width: 5
                                            )
                                        ),
                                        height: 150,
                                        width: 150,
                                        child: Image.asset('assets/Images/schoolEvent/school_event_image.jpg',fit: BoxFit.cover,),

                                      )
                                      // const Center(child: Text('No image selected.'))
                                          : Image.memory(
                                        controller.imageBytes.value!,
                                        fit: BoxFit.contain
                                        , // Fit the image to the container
                                      )),
                                      // */


                                    ),
                                    Positioned(
                                      bottom: 8, // Adjust position as needed
                                      right: 8, // Adjust position as needed
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.pickImage(); // Trigger image picking
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.teal.withOpacity(0.7),
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


                              const SizedBox(width: 40,),

                              //  Time, Date and Description
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    const SizedBox(height: 13),
                                    //  Time Date
                                    Text(
                                      event['date']!,
                                      style: const TextStyle(
                                        // color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    // Text(
                                    //   event['time']!,
                                    //   style: const TextStyle(
                                    //     // color: Colors.white,
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 18,
                                    //   ),
                                    // ),

                                    //  Description
                                    Text(
                                      event['description']!,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add event logic here
          controller.addAndEditEvent(context);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
