import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school/Admin%20Panel/Model/timeTable_model_class.dart';
import 'package:my_school/Admin%20Panel/Pages/TimeTable/Controller/timetable_controller.dart';
// import 'package:my_school/nweTimeTable/Controller/timetable_controller.dart';

// ignore: use_key_in_widget_constructors
class TimeTables extends StatelessWidget {
  final TimeTableController controller = Get.put(TimeTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable"),
        centerTitle: true,

        actions: [
          Obx(() => DropdownButton<String>(
            value: null,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.teal, fontSize: 18),
            underline:
            Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (String? newValue) {
              // timetableController.selectedClass.value = newValue!;
            },
            hint: Text("Select a class"),
            items: controller.classList.map<DropdownMenuItem<String>>((String className) {
              return DropdownMenuItem<String>(
                value: className,
                child: Text(className),
              );
            }).toList(),
          )),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Obx(() {
            // Display loading indicator when timetable is empty
            if (controller.allTimeTables.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Render Timetable List
            return ListView.builder(
              itemCount: controller.allTimeTables.length,
              itemBuilder: (context, index) {
                return _buildTimetableRow(
                    context, controller.allTimeTables[index], index);
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          // Add new timetable logic
          _addFullTimeTable(context);
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

  // Build day rows for the timetable
  Widget _buildTimetableRow(
      BuildContext context, TimeTable timeTable, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDayRow(context, "Monday", timeTable.monday, index),
              _buildDayRow(context, "Tuesday", timeTable.tuesday, index),
              _buildDayRow(context, "Wednesday", timeTable.wednesday, index),
              _buildDayRow(context, "Thursday", timeTable.thursday, index),
              _buildDayRow(context, "Friday", timeTable.friday, index),
              _buildDayRow(context, "Saturday", timeTable.saturday, index),
              const Divider(thickness: 1), // Separate weeks with a divider
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayRow(
      BuildContext context, String dayName, List<Day> dayList, int index) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              dayName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
            ),
          ),
        ),
        SizedBox(
          height: 180, // Set fixed height for horizontal list
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: dayList.length,
            itemBuilder: (context, dayIndex) {
              return Center(
                child: _buildTimeTableCard(
                    context, dayList[dayIndex], dayName, index, dayIndex),
              );
            },
          ),
        ),
      ],
    );
  }

  // Reusable timetable card widget
  Widget _buildTimeTableCard(BuildContext context, Day day, String dayName,
      int tableIndex, int dayIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                day.subject,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (day.teacher.isNotEmpty)
                      ? const Icon(Icons.person, size: 22, color: Colors.green)
                      : const SizedBox(width: 1),
                  const SizedBox(width: 5),
                  Text(
                    day.teacher,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time, size: 18, color: Colors.blue),
                  const SizedBox(width: 5),
                  Text(
                    day.time,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // _getPeriodIcon(day.type),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.teal),
                    onPressed: () {
                      // controller.showEditDialog(
                      _showEditDialog(
                          context, day, dayName, tableIndex, dayIndex);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                          context, dayName, tableIndex, dayIndex);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String dayName, int tableIndex, int dayIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Entry'),
          content: const Text('Are you sure you want to delete this entry?'),
          actions: [
            TextButton(
              onPressed: () {
                controller.deleteDay(tableIndex, dayName, dayIndex);
                Get.back(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Get period icon based on type
  // ignore: unused_element
  Widget _getPeriodIcon(String type) {
    if (type.toLowerCase() == "lunch") {
      return const Icon(Icons.lunch_dining, color: Colors.orange);
    }
    return const Icon(Icons.school, color: Colors.green);
  }

  // Edit Data
  void _showEditDialog(BuildContext context, Day day, String dayName,
      int tableIndex, int dayIndex) {
    final TextEditingController subjectController =
        TextEditingController(text: day.subject);
    final TextEditingController timeController =
        TextEditingController(text: day.time);
    final TextEditingController teacherController =
        TextEditingController(text: day.teacher);
    final TextEditingController typeController =
        TextEditingController(text: day.type);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $dayName Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
              TextField(
                controller: teacherController,
                decoration: const InputDecoration(labelText: 'Teacher'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedDay = Day(
                  subject: subjectController.text,
                  time: timeController.text,
                  teacher: teacherController.text,
                  type: typeController.text,
                );

                print(
                    "Updating day: $updatedDay at index $dayIndex"); // Debugging line

                controller.updateDay(tableIndex, dayName, updatedDay, dayIndex);
                Get.back(); // Close the dialog
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _addFullTimeTable(BuildContext context) {
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController teacherController = TextEditingController();
    final TextEditingController typeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Enter Timetable Details')),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown for Day selection
                _buildDropdown(),
                // Time picker button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[50],
                      side: const BorderSide(color: Colors.teal, width: 2),
                      minimumSize: const Size(240, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => controller.selectTime(context),
                    label: Obx(() => Text(
                          controller.selectedTime.value.format(context),
                          style: const TextStyle(color: Colors.teal),
                        )),
                    icon: const Icon(
                      Icons.access_time_filled_outlined,
                      color: Colors.teal,
                    ),
                  ),
                ),
                // TextFormField for Subject input
                _buildTextField(
                  icon: Icons.menu_book_sharp,
                  label: 'Subject',
                  controller: subjectController,
                ),
                // TextFormField for Teacher input
                _buildTextField(
                  icon: Icons.person,
                  label: 'Teacher',
                  controller: teacherController,
                ),
                // TextFormField for Type input (Period/Lunch)
                _buildTextField(
                  icon: Icons.lunch_dining,
                  label: 'Type (Period/Lunch)',
                  controller: typeController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Create a new Day object with the entered details
                Day newDay = Day(
                  subject: subjectController.text,
                  time: controller.selectedTime.value.format(context),
                  teacher: teacherController.text,
                  type: typeController.text,
                );

                // Add the new Day to the selected day in the timetable
                controller.addNewTimetableEntry(
                    controller.selectedDay.value, newDay);

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

// Custom TextField builder for reusable form fields
  Widget _buildTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.teal,
            size: 25,
          ),
          labelText: label,
          filled: true,
          fillColor: Colors.teal[50],
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Dropdown for selecting a day
  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Obx(() => DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Day',
              labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              filled: true,
              fillColor: Colors.teal[50],
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            dropdownColor: Colors.teal[50],
            icon: const Icon(Icons.date_range_sharp, color: Colors.teal),
            value: controller.selectedDay.value.isEmpty
                ? null
                : controller.selectedDay.value,
            items: controller.days
                .map((day) => DropdownMenuItem(
                      value: day,
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                controller.updateDays(value);
              }
            },
          )),
    );
  }
}
