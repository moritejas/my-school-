import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controller/homework_controller.dart';

class HomeWorks extends StatefulWidget {
  const HomeWorks({super.key});
  @override
  State<HomeWorks> createState() => _HomeWorksState();
}

class _HomeWorksState extends State<HomeWorks> {
  final HomeworkController controller = Get.put(HomeworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("HomeWorks"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Row(
            children: [

//  Select Class
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 4.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Obx((){
                        return DropdownButton<String>(

                          hint: const Text(
                            "Select Class",
                            style: TextStyle(fontSize: 16, color: Colors.teal),
                          ),
                          value: controller.selectedHClass.value.isEmpty
                              ? null
                              : controller.selectedHClass.value,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedHClass.value = newValue;
                              controller.onSelectedClassChanged(newValue);
                              print(controller.selectedHClass.value);
                            }
                          },
                          icon:
                          const Icon(Icons.arrow_downward, color: Colors.teal),
                          iconSize: 20,
                          elevation: 10,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          underline: const SizedBox.shrink(),
                          items: controller.hClass
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
// Select Date
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 4.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.teal,
                          minimumSize: const Size(150, 55),
                          backgroundColor: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () => controller.userSelectedDate(context),

                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.teal,
                        ),

                        label: Obx((){
                          return Text(
                            DateFormat('dd - MM - yyyy')
                                .format(controller.selectedDate.value),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          );
                        }),
                      ),
                    ),

            ],
          ),
          const SizedBox(height: 20),
          // Homework list
          Expanded(
            child: Obx(() {
              return controller.filteredAllHomework.isNotEmpty
                  ? Wrap(
                      spacing: 10, // Add some spacing between items
                      runSpacing: 10,
                      children: List.generate(
                          controller.filteredAllHomework.length, (index) {
                        final allHomeworksData =
                            controller.filteredAllHomework[index];
                        return Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/svg/book-open.svg',
                                        width: 25,
                                        height: 25,
                                        // color: Colors.black54,
                                        color: Colors.teal,
                                      ), // Adjust icon size
                                      const SizedBox(width: 6),
                                      Text(
                                        allHomeworksData.subject,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  SvgPicture.asset(
                                    'assets/icons/svg/newhomework.svg',
                                    width: 30,
                                    height: 30,
                                    // color: Colors.black54,
                                    color: Colors.teal,
                                  ), // Adjust icon size
                                  const SizedBox(height: 6),
                                  Text(
                                    allHomeworksData.homework,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  : const Center(
                      child: Text(
                          'No data available for the selected class and date.'),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
