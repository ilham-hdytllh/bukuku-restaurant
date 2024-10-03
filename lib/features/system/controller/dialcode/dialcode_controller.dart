import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/utils/utils.dart';

class DialCodeController extends GetxController {
  static DialCodeController get instance => Get.find();

  // Varibale
  Rx<String> codePhoneString = "+62".obs;
  Rx<String> selectedCodePhoneString = "+62".obs;
  Rx<TextEditingController> searchDialCode = TextEditingController().obs;
  // Variabel asli dialCodeData
  RxList<dynamic> dialCodeData = [].obs;
  // Variabel untuk menyimpan data yang sudah difilter
  RxList<dynamic> filteredDialCodeData = [].obs;

  @override
  void onInit() async {
    codePhoneString.value = "+62";
    selectedCodePhoneString.value = "+62";
    Get.put(UtilsRepository());
    // currencyCodeData.value =
    //     await StartingSetupRepository.instance.fetchCurrencyCodeData();
    dialCodeData.assignAll(await UtilsRepository.instance.fetchPhoneCodeData());
    // Mengisi filteredCurrencyCodeData dengan data awal
    filteredDialCodeData.assignAll(dialCodeData);
    super.onInit();
  }

  // Update list currency data if text editing is not empty
  void orderBySearch() {
    // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
    filteredDialCodeData.value = dialCodeData.where((element) {
      return element["dial_code"]
          .toString()
          .trim()
          .toLowerCase()
          .contains(searchDialCode.value.text.toString().trim().toLowerCase());
    }).toList(growable: false);
  }

  // Metode untuk reset pencarian
  void resetSearch() {
    // Mengisi filteredCurrencyCodeData kembali dengan currencyCodeData yang asli
    searchDialCode.value.clear();
    filteredDialCodeData.value = dialCodeData;
  }
}
