// ignore_for_file: avoid_print, unused_field, library_private_types_in_public_api, unused_element, deprecated_member_use, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import '../../../../Theme/Text Theme/text_theme.dart';
import '../../../Model/students_get_data_model.dart';
import '../../../Theme/text_theme.dart';

class StudentsPages extends StatefulWidget {
  const StudentsPages({super.key});

  @override
  _StudentsPagesState createState() => _StudentsPagesState();
}

class _StudentsPagesState extends State<StudentsPages> {
  String? _gender;
  final _formKey = GlobalKey<FormState>();

  ListTileTitleAlignment? titleAlignment;

  TextEditingController fullnameController = TextEditingController();
  TextEditingController _standardController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();

  TextEditingController _enrollmentController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _joiningdateController = TextEditingController();

  TextEditingController _idController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  List<StudentsData> _studentsData = [];
  List<StudentsData> _filteredStudents = [];

  // Floating Action Button
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadStudentsData();
  }

// Fetch Student data
  Future<void> _loadStudentsData() async {
    try {
      String data =
          await rootBundle.loadString('assets/studentinformation.json');
      List<dynamic> jsonList = json.decode(data);
      List<StudentsData> students =
          jsonList.map((e) => StudentsData.fromJson(e)).toList();
      setState(() {
        _studentsData = students;
        _filteredStudents = students;
      });
    } catch (e) {
      print('Error loading students data: $e');
    }
  }

  void _toggleFab() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

// Search Student Data (Dialog)
  void showSearchDialog(BuildContext context) {
    String selectedStudentName = '';
    String selectedStandard = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Student'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Student',
                    labelText: "Student",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.teal,
                    ),
                  ),
                  onChanged: (value) {
                    selectedStudentName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Class',
                    labelText: "Class",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.teal,
                    ),
                  ),
                  onChanged: (value) {
                    selectedStandard = value;
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal),
                  child: const Text('Search'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    searchStudent(selectedStudentName, selectedStandard);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

// Search Student Data Function
  void searchStudent(String name, String standards) {
    setState(() {
      _filteredStudents = _studentsData.where((student) {
        final matchesName = name.isEmpty ||
            student.fullname.toLowerCase().contains(name.toLowerCase());
        final matchesStandard = standards.isEmpty ||
            student.standard.toLowerCase().contains(standards.toLowerCase());
        return matchesName && matchesStandard;
      }).toList();
    });
  }

// Filtered Students
  List<StudentsData> _getStudentsToDisplay() {
    return _filteredStudents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//  AppBar
      appBar: AppBar(
        title: const Text(
          'Students',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: [
          Row(
            children: [
              //Icon(Icons.search),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  // _loadStudentsData();
                },
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  showSearchDialog(context);
                },
              ),
            ],
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

//  Body
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 7,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: _getStudentsToDisplay().map((student) {
                      return SizedBox(
                        width: 350,
                        child: Card(
                          elevation: 5,
                          child: ExpansionTile(
//  Name Title
                              title: Text(student.fullname,
                                  style: const TextStyle(fontSize: 20)),
//  Gender Trailing
                              trailing: SvgPicture.asset(
                                student.gender.toLowerCase() == 'male'
                                    ? 'assets/icons/svg/man-com.svg' // Path to your male SVG icon
                                    : 'assets/icons/svg/woman-svgrepo-com.svg', // Path to your female SVG icon
                                width: 30, // Adjust icon size as needed
                                height: 30,
                                color: Colors.teal,
                              ),
//  Subtitle
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
//  Standard
                                  Row(
                                    children: [
//  Book Svg Icon
                                      SvgPicture.asset(
                                        'assets/icons/svg/book-open.svg',
                                        width: 20,
                                        height: 20,
                                        // color: Colors.black54,
                                        color: Colors.teal,
                                      ), // Adjust icon size
                                      const SizedBox(width: 20),
//  Standard Number                                      // Increase spacing
                                      Text(student.standard.toString(),
                                          style:
                                              dTextStyle16()), // Adjust text size
                                    ],
                                  ),

//  Enrollment Number
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/svg/email-svgrepo-com.svg',
                                        width: 20,
                                        height: 20,
                                        // color: Colors.black54,
                                        color: Colors.teal,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(student.enrollmentNumber,
                                          style: dTextStyle16()),
                                    ],
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    children: [
//  Phone Number
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/svg/phone-svgrepo-com.svg',
                                            width: 20,
                                            height: 20,
                                            // color: Colors.black54,
                                            color: Colors.teal,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(student.phoneNumber.toString(),
                                              style: dTextStyle16()),
                                        ],
                                      ),
//  Date of Birth
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/svg/cake-svgrepo-com.svg',
                                            // color: Colors.black54,
                                            color: Colors.teal,
                                            width: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(student.dateOfBirth),
                                            style: dTextStyle16(),
                                          ),
                                        ],
                                      ),
//  Joining Date
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/svg/calender-svgrepo-com.svg',
                                            // color: Colors.black54,
                                            color: Colors.teal,
                                            width: 20,
                                            height: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(student.joiningDate),
                                            style: dTextStyle16(),
                                          ),
                                        ],
                                      ),
//  Address
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/svg/location-pin-svgrepo-com.svg',
                                            width: 20,
                                            height: 20,
                                            // color: Colors.black54,
                                            color: Colors.teal,
                                          ),
                                          const SizedBox(width: 8),
                                          Flexible(
                                            flex: 1,
                                            child: Text(student.address,
                                                style: dTextStyle16()),
                                          ),
                                        ],
                                      ),
//  Delete and Edit
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Edit Button
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              'assets/icons/svg/edit-svgrepo.svg',
                                              width: 20,
                                              height: 20,
                                              // color: Colors.black54,
                                              color: Colors.teal,
                                            ),
                                            onPressed: () {
                                              formAddEditStudent(student);
                                            },
                                          ),
                                          // Delete Button
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              'assets/icons/svg/delete-svgrepo-com.svg',
                                              width: 20,
                                              height: 20,
                                              // color: Colors.black54,
                                              color: Colors.teal,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _studentsData.remove(student);
                                              });
                                              // _deleteStudent(index);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      );
                    }).toList(),
                  ),
                  if (_getStudentsToDisplay().isEmpty &&
                      (_filteredStudents.isEmpty))

                    const Center(child: Text("Data is not Found")),

                  // if (_getStudentsToDisplay().isEmpty &&
                  //     (_studentname.isNotEmpty || _selectedStandard != null))
                  //   const Center(child: Text("Data is not Found")),
                  // Display message if no matching students
                ],
              ),
            ),
          ],
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
              duration: const Duration(milliseconds: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
//  Add Students Button
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        formAddEditStudent(null);
                      },
                      tooltip: 'Add Student',
                      mini: true,
                      child: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(height: 16),
//  Search Students Button
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        showSearchDialog(context);
                      },
                      // _showSearchDialog,
                      tooltip: 'Search',
                      mini: true,
                      child: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 16),
//  Refresh All Students Data Button
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        _loadStudentsData();
                      },
                      tooltip: 'Refresh',
                      mini: true,
                      child: const Icon(Icons.refresh),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: _toggleFab,
              // tooltip: 'Expand',
              child: Icon(_isExpanded ? Icons.close : Icons.menu),
            ),
          ),
        ],
      ),
    );
  }

  // Add and Edit Students Informations
  Future formAddEditStudent(StudentsData? student) {
    if (student != null) {
      fullnameController.text = student.fullname;
      _standardController.text = student.standard.toString();
      _birthdateController.text =
          DateFormat('yyyy-MM-dd').format(student.dateOfBirth);
      _enrollmentController.text = student.enrollmentNumber;
      _phoneController.text = student.phoneNumber.toString();
      _joiningdateController.text =
          DateFormat('yyyy-MM-dd').format(student.joiningDate);
      _idController.text = student.idNo.toString();
      _addressController.text = student.address;
      _gender = student.gender;
    } else {
      fullnameController.clear();
      _standardController.clear();
      _birthdateController.clear();
      _enrollmentController.clear();
      _phoneController.clear();
      _joiningdateController.clear();
      _idController.clear();
      _addressController.clear();
      _gender = null;
    }

    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        final showFullScreenDialog = MediaQuery.sizeOf(context).width < 540;
        // final formKey = GlobalKey<FormState>();
        void handleSubmit() {
          if (_formKey.currentState!.validate()) {
            final fullName = fullnameController.text;
            final enrollmentNumber = _enrollmentController.text;
            final birthdate = _birthdateController.text;
            final standard = _standardController.text;
            final phone = _phoneController.text;
            final joiningDate = _joiningdateController.text;
            final studentId = int.parse(_idController.text);
            final address = _addressController.text;
            final gender = _gender;

            final newStudent = StudentsData(
              idNo: studentId,
              fullname: fullName,
              enrollmentNumber: enrollmentNumber,
              dateOfBirth: DateFormat('yyyy-MM-dd').parse(birthdate),
              standard: standard,
              phoneNumber: int.parse(phone),
              joiningDate: DateFormat('yyyy-MM-dd').parse(joiningDate),
              address: address,
              gender: gender!,
            );

            setState(() {
              if (student == null) {
                _studentsData.add(newStudent);
              } else {
                final index = _studentsData.indexOf(student);
                _studentsData[index] = newStudent;
              }
            });

          }
        }

        Widget dialogContent = Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Wrap(
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 8.0,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                            child: Text(
                              "Student",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Fullname
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: fullnameController,
                        decoration: InputDecoration(
                          hintText: 'Student Name',
                          labelText: "Enter Student Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.teal,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Student Full name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Standard
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _standardController,
                        decoration: InputDecoration(
                          hintText: 'Standard',
                          labelText: "Enter Standard",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
                            Icons.menu_book_outlined,
                            color: Colors.teal,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Standard';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Date of Birth
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _birthdateController,
                        decoration: InputDecoration(
                          hintText: 'Birth date',
                          labelText: 'Select Birth date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.teal,
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? birthdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );

                          if (birthdate != null) {
                            setState(() {
                              _birthdateController.text =
                                  DateFormat('yyyy-MM-dd').format(birthdate);
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Birth Date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Email
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _enrollmentController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: "Enter E-mail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.teal,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter e-mail';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Phone Number
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'Contact Number',
                          labelText: "Enter Contact Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
                            Icons.call_rounded,
                            color: Colors.teal,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Contact Number';
                          } else if (value.length != 10) {
                            return 'Contact Number must be 10 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Joining Date
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _joiningdateController,
                        decoration: InputDecoration(
                          hintText: 'Joining date',
                          labelText: 'Select Joining date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.teal,
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? birthdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (birthdate != null) {
                            setState(() {
                              _joiningdateController.text =
                                  DateFormat('yyyy-MM-dd').format(birthdate);
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Joining Date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Student Address
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          hintText: 'Enter Student Address',
                          labelText: "Student Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.teal,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Student Address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Gender
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.account_circle_outlined,
                            color: Colors.teal,
                          ),
                        ),
                        value: _gender,
                        items: const [
                          DropdownMenuItem(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _gender = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Submit and Cancel Buttons
                  Wrap(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
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
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                )),
                              ),
                              onPressed: handleSubmit,
                              //     () {
                              //
                              //   if (_formKey.currentState!.validate()) {
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //         content: Text(
                              //           'Submitted',
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 24,
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   }
                              // },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

        if (showFullScreenDialog) {
          print("mobile view");
          return Dialog.fullscreen(
            child: dialogContent,
          );
        } else {
          print("web view");
          return Dialog(
            elevation: 10,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: dialogContent,
            ),
          );
        }
      },
    );
  }
}
