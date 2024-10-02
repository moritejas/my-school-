import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/subject_controller.dart';
// import 'package:get/get.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final SubjectController controller = Get.put(SubjectController());
  // Floating Action Button
  bool _isExpanded = false;
  void _toggleFab() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subject",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                _cotainers(),
                _cotainers(),
                _cotainers(),
                _cotainers(),
                _cotainers(),
                _cotainers(),
                _cotainers(),
                _cotainers(),
                _cotainers(),
              ],
            ),
          ),
        ),
      ),

      // Floating Action Button (Add, Search, Refresh)
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 90,
            right: 4,
            child: AnimatedOpacity(
              opacity: _isExpanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
//  Add Students Button
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        // formAddEditStudent(null);
                        controller.addAndEditClassSubject(context);
                      },
                      tooltip: 'Add Student',
                      mini: true,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
//  Search Students Button
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        controller.addAndEditClassSubject(context);
                      },
                      // _showSearchDialog,
                      tooltip: 'Search',
                      mini: true,
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
//  Refresh All Students Data Button
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        // _loadStudentsData();
                      },
                      tooltip: 'Refresh',
                      mini: true,
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: _toggleFab,
              // tooltip: 'Expand',
              child: Icon(
                _isExpanded ? Icons.close : Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _cotainers() {
    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// elevation: 1,
        // shadowColor: Colors.redAccent,56
        color: Colors.teal.withOpacity(0.5),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10.0),
            // height: 170,
            width: 150,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        child: Container(
                          // color: Colors.teal.withOpacity(0.2),
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(23, 5, 23, 5),
                              child: Text(
                                'Class 10',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                    child: Column(
                      children: [
                        const Text('Flutter'),
                        const Text('Dart'),
                        const Text('GetX'),
                        const Text('Bloc'),
                        const Text('Figma'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.teal),
                              onPressed: () {
                                controller.addAndEditClassSubject(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


