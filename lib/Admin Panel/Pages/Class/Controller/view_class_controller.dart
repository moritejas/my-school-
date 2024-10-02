import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Model/class_model.dart';

class ViewClassController extends GetxController {
  var classes = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadClassesData();
  }

  Future<void> loadClassesData() async {
    try {
      String data = await rootBundle.loadString('assets/allclasses.json');
      Map<String, dynamic> jsonData = json.decode(data);

      final Classes allClasses = Classes.fromJson(jsonData);
      classes.value = allClasses.classes..sort((a, b) => customSort(a, b));
    } catch (e) {
      print('Error loading class data: $e');
      Get.snackbar('Error', 'Failed to load class data',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  int customSort(String a, String b) {
    // Regular expression to extract numeric parts from the class name
    final numericRegex = RegExp(r'(\d+)');

    // Find all numeric parts in both class names
    final matchA = numericRegex.firstMatch(a);
    final matchB = numericRegex.firstMatch(b);

    if (matchA != null && matchB != null) {
      // Compare numeric parts if both class names contain numbers
      final numA = int.parse(matchA.group(0)!);
      final numB = int.parse(matchB.group(0)!);

      // If the numeric parts are equal, compare the full strings alphabetically
      if (numA == numB) {
        return a.compareTo(b);
      }
      return numA.compareTo(numB);
    } else {
      // If one of the class names doesn't contain a number, sort alphabetically
      return a.compareTo(b);
    }
  }
}
