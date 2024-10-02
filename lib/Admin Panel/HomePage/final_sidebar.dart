// ignore_for_file: library_private_types_in_public_api, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../Pages/Class/View/class.dart';
import '../Pages/Dashboard/View/addmin_page.dart';
import '../Pages/Events/View/newEventPage.dart';
import '../Pages/Gallery/View/gallery.dart';
import '../Pages/Homework/View/homework.dart';
import '../Pages/Result/result.dart';
import '../Pages/Student Attendance/Attendance/attendace.dart';
import '../Pages/Students/View/new_student_page.dart';
import '../Pages/Subject/View/subject.dart';
import '../Pages/TimeTable/View/time_table.dart';
import '../Pages/teacher/View/final_teacher.dart';

class FinalResponsiveSidebar extends StatefulWidget {
  @override
  _FinalResponsiveSidebarState createState() => _FinalResponsiveSidebarState();
}

class _FinalResponsiveSidebarState extends State<FinalResponsiveSidebar> {
  String _selectedPage = 'Dashboard';
  bool _isSidebarExpanded = true;

  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'Dashboard','icon': Icons.dashboard,},
    {'title': 'Teacher', 'icon': Icons.person},
    {'title': 'Student', 'icon': Icons.people},
    {'title': 'Attendance', 'icon': Icons.check},
    {'title': 'Class', 'icon': Icons.class_},
    {'title': 'Events', 'icon': Icons.schedule},
    {'title': 'Subject', 'icon': Icons.note_alt_rounded},
    {'title': 'TimeTable', 'icon': Icons.schedule},
    {'title': 'Homework', 'icon': Icons.holiday_village_outlined},
    {'title': 'Results', 'icon': Icons.pending_actions_rounded},
    {'title': 'Gallery', 'icon': Icons.image_outlined},
  ];

  Widget _getPage(String page) {
    switch (page) {
      case 'Dashboard':
        return const Dashboard();
      case 'Teacher':
        return NewTeacherPaged();
      case 'Student':
        return const StudentsPages();
      case 'Attendance':
        return const StudentAttendance();
      case 'Class':
        return const Classed();
      case 'Subject':
        return const SubjectPage();
      case 'TimeTable':
        return TimeTables();
      case 'Events':
        return EventsPage();
      case 'Results':
        return const Results();
      case 'Gallery':
        return const Gallery();
      case 'Homework':
        return const HomeWorks();
      default:
        return const Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 540;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
        ),
        body: _getPage(_selectedPage),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (int i = 0; i < _menuItems.length && i < 3; i++)
                IconButton(
                  icon: Icon(_menuItems[i]['icon']),
                  onPressed: () {
                    setState(() {
                      _selectedPage = _menuItems[i]['title'];
                    });
                  },
                ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('More'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              for (int i = 3; i < _menuItems.length; i++)
                                ListTile(
                                  leading: Icon(
                                    _menuItems[i]['icon'],
                                    color:
                                        _getIconColor(_menuItems[i]['title']),
                                  ),
                                  title: Text(_menuItems[i]['title']),
                                  onTap: () {
                                    setState(() {
                                      _selectedPage = _menuItems[i]['title'];
                                    });
                                    Navigator.pop(context); // Close the dialog
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    //Web View
    else {
      double sidebarWidth = _isSidebarExpanded ? 200.0 : 70.0;
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text("My School"),
        // ),
        body: Row(
          children: <Widget>[
            Container(
              width: sidebarWidth,
              color: Colors.teal,
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isSidebarExpanded = !_isSidebarExpanded;
                        });
                      },
                      child: _isSidebarExpanded
                          ? const Row(
                              children: [
                                Icon(Icons.menu, color: Colors.white, size: 30),
                                SizedBox(width: 10),
                                Text(
                                  'Menu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            )
                          : const Icon(Icons.menu,
                              color: Colors.white, size: 30),
                    ),
                  ),
                  for (var item in _menuItems)
                    ListTile(
                      leading: Icon(item['icon'], color: Colors.white),
                      title: _isSidebarExpanded
                          ? Text(item['title'],
                              style: const TextStyle(color: Colors.white))
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedPage = item['title'];
                        });
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              child: _getPage(_selectedPage),
            ),
          ],
        ),
      );
    }
  }

  // Helper method to get icon color based on the title
  Color _getIconColor(String title) {
    switch (title) {
      case 'Class':
        return Colors.teal;
      case 'Subject':
        return Colors.teal;
      // Add more cases for other titles if needed
      default:
        return Colors.teal; // Default color
    }
  }
}
