import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_bukuku/data/repositories/utils/utils.dart';
import 'package:restaurant_bukuku/features/authentication/screens/signup/verify_email.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class StartingSetupController extends GetxController {
  static StartingSetupController get instance => Get.find();

  /// Variables
  GlobalKey<FormState> formSetupOne = GlobalKey<FormState>();
  GlobalKey<FormState> formSetupTwo = GlobalKey<FormState>();
  final restaurantName = TextEditingController();
  final restaurantCurrency = TextEditingController();

  Rx<String> currencyFormatString = "IDR".obs;
  Rx<String> selectedCurrencyFormatString = "IDR".obs;
  Rx<TextEditingController> searchCurrencyCode = TextEditingController().obs;
  // Variabel asli currencyCodeData
  RxList<dynamic> currencyCodeData = [].obs;
  // Variabel untuk menyimpan data yang sudah difilter
  RxList<dynamic> filteredCurrencyCodeData = [].obs;

  final menuName = TextEditingController();
  final menuPrice = TextEditingController();

  // String imageUrl = '';
  // String imageName = '';
  Uint8List webImage = Uint8List(8);
  Rx<File?> mobileImage = Rx<File?>(null);
  Rx<XFile?> mobileImageForUpload = Rx<XFile?>(null);

  Uint8List webImageMenu = Uint8List(8);
  Rx<File?> mobileImageMenu = Rx<File?>(null);
  Rx<XFile?> mobileImageMenuForUpload = Rx<XFile?>(null);

  RxList<String> restaurantType = <String>[].obs;
  RxList<String> restaurantTypeData = <String>[
    "Japanese",
    "Korean",
    "Western",
    "Chinese",
    "Asian",
    "Fast Food",
  ].obs;

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  @override
  void onInit() async {
    restaurantCurrency.text = "IDR";
    Get.put(UtilsRepository());
    // currencyCodeData.value =
    //     await StartingSetupRepository.instance.fetchCurrencyCodeData();
    currencyCodeData
        .assignAll(await UtilsRepository.instance.fetchCurrencyCodeData());
    // Mengisi filteredCurrencyCodeData dengan data awal
    filteredCurrencyCodeData.assignAll(currencyCodeData);
    super.onInit();
  }

  // Update list currency data if text editing is not empty
  void orderBySearch() {
    // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
    filteredCurrencyCodeData.value = currencyCodeData.where((element) {
      return element["currency_code"].toString().trim().toLowerCase().contains(
          searchCurrencyCode.value.text.toString().trim().toLowerCase());
    }).toList(growable: false);
  }

  // Metode untuk reset pencarian
  void resetSearch() {
    // Mengisi filteredCurrencyCodeData kembali dengan currencyCodeData yang asli
    searchCurrencyCode.value.clear();
    filteredCurrencyCodeData.value = currencyCodeData;
  }

  // Get restaurant image from gallery
  Future<void> getRestaurantImageFromGallery() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        mobileImageForUpload.value = image;
        var selected = File(image.path);

        mobileImage.value = selected;

        Get.back();
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        mobileImageForUpload.value = image;
        var f = await image.readAsBytes();

        webImage = f;
        mobileImage.value = File('a');

        Get.back();
      }
    }
  }

  // Get restaurant image from camera
  Future<void> getRestaurantImageFromCamera() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        mobileImageForUpload.value = image;
        var selected = File(image.path);

        mobileImage.value = selected;
        Get.back();
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        mobileImageForUpload.value = image;
        var f = await image.readAsBytes();

        webImage = f;
        mobileImage.value = File('a');
        Get.back();
      }
    }
  }

  // Get menu image from gallery
  Future<void> getMenuImageFromGallery() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        mobileImageMenuForUpload.value = image;
        var selected = File(image.path);

        mobileImageMenu.value = selected;
        Get.back();
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        mobileImageMenuForUpload.value = image;
        var f = await image.readAsBytes();

        webImageMenu = f;
        mobileImageMenu.value = File('a');

        Get.back();
      }
    }
  }

  // Get menu image from camera
  Future<void> getMenuImageFromCamera() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        mobileImageMenuForUpload.value = image;
        var selected = File(image.path);

        mobileImageMenu.value = selected;
        Get.back();
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        mobileImageMenuForUpload.value = image;
        mobileImageForUpload.value = image;
        var f = await image.readAsBytes();

        webImageMenu = f;
        mobileImageMenu.value = File('a');
        Get.back();
      }
    }
  }

  /// Update current index when page scroll
  void updatePage(index) => currentPageIndex.value = index;

  /// Update current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 1) {
      // Navigate to verify email
      if (formSetupTwo.currentState!.validate()) {
        Get.to(VerifyEmailScreen());
      }
    } else {
      if (formSetupOne.currentState!.validate()) {
        if (restaurantType.isEmpty) {
          Get.snackbar('Sorry', 'Silahkan pilih type restaurant anda',
              backgroundColor: TColors.error,
              colorText: TColors.white,
              snackPosition: SnackPosition.TOP);
        } else {
          int page = currentPageIndex.value + 1;
          pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }
  }

  /// Update current index & jump to next page
  void previousPage() {
    if (currentPageIndex.value == 0) {
      // No condition
      null;
    } else {
      int page = currentPageIndex.value - 1;

      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
