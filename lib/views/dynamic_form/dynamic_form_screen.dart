import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vupadhi/app/theme/colors.dart';
import 'package:vupadhi/data/models/get_all_service_list_model.dart';
import 'package:vupadhi/viewmodels/dynamic_form_vm.dart';

class DynamicFormScreen extends StatelessWidget {
  final Datum service;
  final Uint8List? imageBytes;

  DynamicFormScreen({required this.service, this.imageBytes});

  final DynamicFormVm viewModel = Get.put(DynamicFormVm());

  @override
  Widget build(BuildContext context) {
    viewModel.initializeFields(service);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Obx(() => Text(
              '${viewModel.categoryName.value}',
              style: const TextStyle(color: Colors.white),
            )),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imageBytes != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.memory(
                    imageBytes!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  '${viewModel.serviceName.value}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: viewModel.fields.map((field) {
                      if (field == 'Gender' || field == 'Pension Category') {
                        return Column(
                          children: [
                            _buildDropdownField(field),
                            const SizedBox(height: 16),
                          ],
                        );
                      }
                      if (field == 'Age') {
                        return Column(
                          children: [
                            _buildAgePicker(),
                            const SizedBox(height: 16),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          _buildTextField(field),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  viewModel.submitForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String? field) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: field,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      keyboardType: field == 'Mobile Number' ||
              field == 'Aadhar Number' ||
              field == 'Account Number'
          ? TextInputType.number
          : TextInputType.text,
      maxLength: field == 'Mobile Number' ? 10 : null,
      validator: (value) {
        if (field == 'Mobile Number') {
          return viewModel.validateMobile(value);
        }
        if (field == 'Email') {
          return viewModel.validateEmail(value);
        }
        if (value == null || value.isEmpty) {
          return '$field is required';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String? field) {
    List<String> items = [];
    if (field == 'Gender') {
      items = ['Male', 'Female', 'Other'];
    } else if (field == 'Pension Category') {
      items = ['Category 1', 'Category 2', 'Category 3'];
    }

    return Container(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: field,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (value) {
          if (field == 'Gender') {
            viewModel.gender.value = value ?? '';
          } else if (field == 'Pension Category') {
            viewModel.pensionCategory.value = value ?? '';
          }
        },
        validator: (value) {
          if (value == null) {
            return '$field is required';
          }
          return null;
        },
        isExpanded: false,
      ),
    );
  }

  Widget _buildAgePicker() {
    return FormField<DateTime?>(
      initialValue: viewModel.birthDate.value,
      validator: (value) {
        if (value == null) {
          return 'Please select your birthdate';
        }
        return null;
      },
      onSaved: (newValue) {
        viewModel.birthDate.value = newValue;
      },
      builder: (FormFieldState<DateTime?> field) {
        return GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              field.didChange(pickedDate);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: field.hasError ? Colors.red : Colors.grey,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  field.value != null
                      ? '${field.value!.toLocal()}'.split(' ')[0]
                      : 'Select Birth Date',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const Spacer(),
                const Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
