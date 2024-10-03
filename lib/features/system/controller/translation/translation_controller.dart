import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationController extends GetxController {
  static TranslationController get instance => Get.find();

  /// Variables
  RxString selectedOption = 'id'.obs;

  @override
  void onInit() {
    super.onInit();
    selectedOption.value = Get.locale!.languageCode;
  }

  // Fungsi untuk mengubah ui radio
  void setSelectedOption(String option) {
    selectedOption.value = option;
  }

  // Fungsi untuk mengubah locale
  void setLocale() {
    if (selectedOption.value == 'id') {
      Get.updateLocale(const Locale('id', 'ID'));
      Get.back();
    } else {
      Get.updateLocale(const Locale('en', 'US'));
      Get.back();
    }
  }
}
