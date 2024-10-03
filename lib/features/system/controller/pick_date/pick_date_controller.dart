import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PickDateController extends GetxController {
  static PickDateController get instance => Get.find();

  void showDialogDatePicker(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930, 01),
      lastDate: DateTime(2100, 12),
    );
    if (picked != null) {
      final time = TimeOfDay.fromDateTime(DateTime.now());
      final dateTime = DateTime(
          picked.year, picked.month, picked.day, time.hour, time.minute);
      controller.text = DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }
}
