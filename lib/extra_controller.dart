// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'homework_controller.dart';  // Controller
//
// class HomeworkPage extends StatelessWidget {
//   final HomeworkController controller = Get.put(HomeworkController());
//
//   @override
//   Widget build(BuildContext context) {
//     // Load homework data when the app starts
//     controller.loadHomeworkData();
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Select Class and Date')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Dropdown for selecting class
//             Obx(() => DropdownButton<String>(
//               hint: Text('Select Class'),
//               value: controller.selectedClass.value.isNotEmpty ? controller.selectedClass.value : null,
//               onChanged: (newValue) {
//                 controller.selectedClass.value = newValue ?? '';
//                 controller.filterHomework();  // Filter when class is selected
//               },
//               items: controller.homeworkData.value.homeworkByClass.keys.map<DropdownMenuItem<String>>((className) {
//                 return DropdownMenuItem<String>(
//                   value: className,
//                   child: Text(className),
//                 );
//               }).toList(),
//             )),
//
//             SizedBox(height: 20),
//
//             // Dropdown for selecting date
//             Obx(() => DropdownButton<String>(
//               hint: Text('Select Date'),
//               value: controller.selectedDate.value.isNotEmpty ? controller.selectedDate.value : null,
//               onChanged: (newValue) {
//                 controller.selectedDate.value = newValue ?? '';
//                 controller.filterHomework();  // Filter when date is selected
//               },
//               items: (controller.selectedClass.value.isNotEmpty
//                   ? controller.homeworkData.value.homeworkByClass[controller.selectedClass.value]?.map<DropdownMenuItem<String>>((homework) {
//                 return DropdownMenuItem<String>(
//                   value: homework.date,
//                   child: Text(homework.date),
//                 );
//               }).toList()
//                   : [])
//                   ?.toSet() // remove duplicates
//                   .toList(),
//             )),
//
//             SizedBox(height: 20),
//
//             // Display filtered homework data
//             Obx(() {
//               if (controller.filteredHomework.isEmpty) {
//                 return Text('No data available for the selected class and date.');
//               } else {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: controller.filteredHomework.length,
//                     itemBuilder: (context, index) {
//                       final homework = controller.filteredHomework[index];
//                       return ListTile(
//                         title: Text(homework.subject),
//                         subtitle: Text(homework.homework),
//                       );
//                     },
//                   ),
//                 );
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
