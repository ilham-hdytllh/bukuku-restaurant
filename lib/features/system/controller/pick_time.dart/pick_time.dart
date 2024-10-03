import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickTimeController extends GetxController {
  static PickTimeController get instance => Get.find();

  void showDialogDatePicker(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
    }
  }
}
