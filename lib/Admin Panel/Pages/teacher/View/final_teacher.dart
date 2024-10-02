// ignore_for_file: avoid_print, unused_field, library_private_types_in_public_api, unused_element, deprecated_member_use, prefer_final_fields, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Model/teacher_data_model_class.dart';
import '../../../Theme/text_theme.dart';

class NewTeacherPaged extends StatefulWidget {
  @override
  _NewTeacherPagedState createState() => _NewTeacherPagedState();
}

class _NewTeacherPagedState extends State<NewTeacherPaged> {
  String? _gender;
  final _formKey = GlobalKey<FormState>();

  ListTileTitleAlignment? titleAlignment;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController _subjectsController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _joiningdateController = TextEditingController();

  TextEditingController _idController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  List<TeachersData> _teachersData = [];
  List<TeachersData> _filteredTeachers = [];
  // Floating Action Button
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadTeachersData();
  }

//  Fetch Teacher Data
  Future<void> _loadTeachersData() async {
    try {
      String data =
          await rootBundle.loadString('assets/teacherinformation.json');
      List<dynamic> jsonList = json.decode(data);
      List<TeachersData> teachers =
          jsonList.map((e) => TeachersData.fromJson(e)).toList();
      setState(() {
        _teachersData = teachers;
        _filteredTeachers = teachers;
      });
    } catch (e) {
      print('Error loading teachers data: $e');
    }
  }

  void _toggleFab() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

//  Search Dialog Box
  void showSearchDialog(BuildContext context) {
    String selectedTeacherName = '';
    String selectedSubject = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Teacher'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Teacher',
                    labelText: "Teacher",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.teal,
                    ),
                  ),
                  onChanged: (value) {
                    selectedTeacherName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Subject',
                    labelText: "Subject",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.teal,
                    ),
                  ),
                  onChanged: (value) {
                    selectedSubject = value;
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
                    _searchTeacher(selectedTeacherName, selectedSubject);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

// Search Student Function
  void _searchTeacher(String name, String subject) {
    setState(() {
      _filteredTeachers = _teachersData.where((teacher) {
        final matchesName = name.isEmpty ||
            teacher.fullname.toLowerCase().contains(name.toLowerCase());
        final matchesSubject = subject.isEmpty ||
            teacher.subjects.toLowerCase().contains(subject.toLowerCase());
        return matchesName && matchesSubject;
      }).toList();
    });
  }

  List<TeachersData> _getTeachersToDisplay() {
    return _filteredTeachers;
  }

  @override
  Widget build(BuildContext context) {
    // print("run the application");
    return Scaffold(
//  AppBar
      appBar: AppBar(
        title: const Text(
          'Teachers',
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
                  _loadTeachersData();
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
                    children: _getTeachersToDisplay().map((teacher) {
                      return SizedBox(
                        width: 350,
                        child: Card(
                          elevation: 5,
                          child: ExpansionTile(
                              title: Text(teacher.fullname,
                                  style: const TextStyle(fontSize: 20)),
                              // Gender
                              trailing: SvgPicture.asset(
                                teacher.gender.toLowerCase() == 'male'
                                    ? 'assets/icons/svg/man-com.svg' // Path to your male SVG icon
                                    : 'assets/icons/svg/woman-svgrepo-com.svg', // Path to your female SVG icon
                                width: 30, // Adjust icon size as needed
                                height: 30,
                                color: Colors.teal,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Subject
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/svg/book-open.svg',
                                        width: 20,
                                        height: 20,
                                        // color: Colors.black54,
                                        color: Colors.teal,
                                      ),
                                      const SizedBox(
                                          width: 8), // Increase spacing
                                      Text(
                                        teacher.subjects,
                                        // style: const TextStyle(
                                        //     fontSize: 16)
                                        style: dTextStyle16(),
                                      ),
                                    ],
                                  ),
                                  // Phone Number
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
                                      Text(teacher.phoneNumber.toString(),
                                          style: dTextStyle14()),
                                    ],
                                  ),
                                  // Email
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
                                      Text(teacher.email,
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
                                      // Date of Birth
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
                                                .format(teacher.dateOfBirth),
                                            style: dTextStyle16(),
                                          ),
                                        ],
                                      ),
                                      // Joining Date
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
                                                .format(teacher.joiningDate),
                                            style: dTextStyle16(),
                                          ),
                                        ],
                                      ),
                                      // Address
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
                                            child: Text(teacher.address,
                                                style: dTextStyle16()),
                                          ),
                                        ],
                                      ),
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
                                              formAddEditTeacher(teacher);
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
                                                _teachersData.remove(teacher);
                                              });
                                              // _deleteTeacher(index);
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
                  if (_getTeachersToDisplay().isEmpty &&
                      (_filteredTeachers.isEmpty))
                    const Center(child: Text("Data is not Found")),
                ],
              ),
            ),
          ],
        ),
      ),

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
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        formAddEditTeacher(null);
                      },
                      tooltip: 'Add Teacher',
                      mini: true,
                      child: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        // _searchTeacher;
                        showSearchDialog(context);
                      },
                      // _showSearchDialog,
                      tooltip: 'Search',
                      mini: true,
                      child: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        _loadTeachersData();
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

  //Add and Edit Teachers Informations
  Future formAddEditTeacher(TeachersData? teacher) {
    if (teacher != null) {
      fullnameController.text = teacher.fullname;
      _subjectsController.text = teacher.subjects;
      _birthdateController.text =
          DateFormat('yyyy-MM-dd').format(teacher.dateOfBirth);
      _emailController.text = teacher.email;
      _phoneController.text = teacher.phoneNumber.toString();
      _joiningdateController.text =
          DateFormat('yyyy-MM-dd').format(teacher.joiningDate);
      _idController.text = teacher.idNo.toString();
      _addressController.text = teacher.address;
      _gender = teacher.gender;
    } else {
      fullnameController.clear();
      _subjectsController.clear();
      _birthdateController.clear();
      _emailController.clear();
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
        final showFullScreenDialog = MediaQuery.sizeOf(context).width < 530;
        // final formKey = GlobalKey<FormState>();
        void handleSubmit() {
          if (_formKey.currentState!.validate()) {
            final fullName = fullnameController.text;
            final subject = _subjectsController.text;
            final birthdate = _birthdateController.text;
            final email = _emailController.text;
            final phone = _phoneController.text;
            final joiningDate = _joiningdateController.text;
            final teacherId = int.parse(_idController.text);
            final address = _addressController.text;
            final gender = _gender;

            final newTeacher = TeachersData(
              idNo: teacherId,
              fullname: fullName,
              subjects: subject,
              dateOfBirth: DateFormat('yyyy-MM-dd').parse(birthdate),
              email: email,
              phoneNumber: int.parse(phone),
              joiningDate: DateFormat('yyyy-MM-dd').parse(joiningDate),
              address: address,
              gender: gender!,
            );

            setState(() {
              if (teacher == null) {
                _teachersData.add(newTeacher);
              } else {
                final index = _teachersData.indexOf(teacher);
                _teachersData[index] = newTeacher;
              }
            });
            Get.back();
          }
        }

        Widget dialogContent = Card(
          shadowColor: Colors.grey,
          elevation: 8,
          child: Padding(
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
                                "Teacher",
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
                            hintText: 'Teacher Name',
                            labelText: "Enter Teacher Full Name",
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
                              return 'Please enter the Teacher Full name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    // Subject Name
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: _subjectsController,
                          decoration: InputDecoration(
                            hintText: 'Subject',
                            labelText: "Enter Subject Name",
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
                              return 'Please enter the Subject name';
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
                          controller: _emailController,
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
                    // Teacher Address
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: 'Enter Teacher Address',
                            labelText: "Teacher Address",
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
                              return 'Please enter Teacher Address';
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
