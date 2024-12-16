import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vupadhi/data/models/get_all_service_list_model.dart';

class DynamicFormVm extends GetxController {
  var serviceName = ''.obs;
  var categoryName = ''.obs;
  var gender = ''.obs;
  var pensionCategory = ''.obs;
  var mobileNumber = ''.obs;
  var email = ''.obs;
  var birthDate = Rxn<DateTime>();

  var fields = <String?>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initializeFields(Datum service) {
    serviceName.value = service.serviceName!;
    categoryName.value = service.categoryName!;

    /// Define all possible fields
    List<String?> allFields = [
      service.field1,
      service.field2,
      service.field3,
      service.field4,
      service.field5,
      service.field6,
      service.field7,
      service.field8,
      service.field9,
      service.field10,
      service.field11,
      service.field12,
      service.field13,
      service.field14,
      service.field15,
      service.field16,
      service.field17,
      service.field18,
    ];

    fields.value = allFields.where((field) => field != null).toList();
  }

  /// Validation for mobile number (10 digits)
  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile Number is required';
    }
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number (10 digits)';
    }
    return null;
  }

  /// Validation for email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Method to calculate age from birth date
  int? calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Function to handle form submission
  void submitForm() {
    if (formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "'Form submitted successfully'",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
