import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_bukuku/data/repositories/branch/branch_repository.dart';
import 'package:restaurant_bukuku/data/repositories/employe/employe_repository.dart';
import 'package:restaurant_bukuku/data/repositories/firebase_storage/image/firebase_storage_image_repository.dart';
import 'package:restaurant_bukuku/data/repositories/merchant/merchant_repository.dart';
import 'package:restaurant_bukuku/features/personalization/controllers/merchant_controller.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/about_outlet_page.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/about_restaurant.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/pin_and_password_page.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/profile.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/reset_data_page.dart';
import 'package:restaurant_bukuku/features/system/controller/address_from_map/address_from_map.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();
  final localStorage = GetStorage();

  final formNameKey = GlobalKey<FormState>();
  final formBranchKey = GlobalKey<FormState>();
  final formMerchantKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;
  final profileName = TextEditingController();
  final branchName = TextEditingController();
  final branchPhoneNumber = TextEditingController();
  final restaurantName = TextEditingController();
  RxString employeNameActive = "".obs;
  RxString employeIDActive = "".obs;
  RxString employeRoleActive = "".obs;
  RxString employeEmailActive = "".obs;
  RxString branchNameActive = "".obs;
  RxString branchIDActive = "".obs;
  RxString branchAddressActive = "".obs;
  RxString branchDialCodeActive = "".obs;
  RxString branchPhoneActive = "".obs;

  RxString merchantNameActive = "".obs;
  RxString merchantCurrencyActive = "".obs;
  RxString merchantLogoActive = "".obs;

  Uint8List webImage = Uint8List(8);
  Rx<File?> mobileImage = Rx<File?>(null);
  Rx<XFile?> mobileImageForUpload = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
    initProfileData();
    initMerchantData();
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

  // init merchant data
  Future<void> initMerchantData() async {
    final merchantController = Get.put(MerchantController());

    final dataMerchant =
        await merchantController.merchantRepository.getMerchantRecord();

    merchantNameActive.value = dataMerchant.restaurantName;
    merchantLogoActive.value = dataMerchant.restaurantLogo;
    merchantCurrencyActive.value = dataMerchant.restaurantCurrency;
  }

  // update profil name
  Future<void> updateProfileName() async {
    try {
      // show loading
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        return;
      }

      // form validation
      if (!formNameKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // call controller employe repository
      final employeRepository = Get.put(EmployeRepository());
      // Save employe data in the firebase database
      await employeRepository.updateEmployeName(
          employeIDActive.value, profileName.text.trim());

      employeNameActive.value = profileName.text.trim();

      profileName.clear();

      // close dialog
      Get.back();

      // show success dialog
      CustomSnackbar.successSnackbar(title: "Success", message: "Data updated");

      // stop loading
      isLoading.value = false;
    } catch (e) {
      // stop loading
      isLoading.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error", message: "Please try again later");
    }
  }

  // update merchant data
  Future<void> updateMerchantData() async {
    // call controller Image firebase storage repository
    final firebaseStorageImageRepository =
        Get.put(ImageFirebaseStorageRepository());
    try {
      // show loading
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        return;
      }

      // form validation
      if (!formMerchantKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // variable url image restaurant logo
      String urlRestaurantLogo = "";

      // cek the image is null or not , if not continue to upload firebase storage
      if (mobileImageForUpload.value != null) {
        urlRestaurantLogo = await firebaseStorageImageRepository.uploadImage(
            "Logos/", mobileImageForUpload.value!);

        await firebaseStorageImageRepository
            .deleteImage(merchantLogoActive.value);
      }

      // call controller merchant repository
      final merchantRepository = Get.put(MerchantRepository());
      // Save merchant data in the firebase database
      await merchantRepository.updateMerchantSpesifikData(
          restaurantName.text.trim(), urlRestaurantLogo);

      restaurantName.clear();

      // close dialog
      Get.back();

      initMerchantData();

      // show success dialog
      CustomSnackbar.successSnackbar(title: "Success", message: "Data updated");

      // stop loading
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
      // stop loading
      isLoading.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error", message: "Please try again later");
    }
  }

  // update branch data
  Future<void> updateBranchData() async {
    try {
      // show loading
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        return;
      }

      // form validation
      if (!formBranchKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // call controller branch repository
      final branchRepository = Get.put(BranchRepository());

      // Save branch data in the firebase database
      await branchRepository.updateBranchSpesifikData(branchIDActive.value,
          branchName.text.trim(), branchPhoneNumber.text.trim());

      branchNameActive.value = branchName.text.trim();
      branchPhoneActive.value = branchPhoneNumber.text.trim();

      branchName.clear();
      branchPhoneNumber.clear();

      // close dialog
      Get.back();

      // show success dialog
      CustomSnackbar.successSnackbar(title: "Success", message: "Data updated");

      // stop loading
      isLoading.value = false;
    } catch (e) {
      // stop loading
      isLoading.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error", message: "Please try again later");
    }
  }

  // update branch address
  Future<void> updateBranchAddress() async {
    try {
      // show loading
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        return;
      }

      // call controller branch repository
      final branchRepository = Get.put(BranchRepository());
      final mapPicked = Get.put(AddressFromMapController());

      // Save branch address in the firebase database
      await branchRepository.updateBranchAddress(
          branchIDActive.value,
          mapPicked.address.value.isNotEmpty
              ? mapPicked.address.value
              : branchAddressActive.value);

      branchAddressActive.value = mapPicked.address.value.isNotEmpty
          ? mapPicked.address.value
          : branchAddressActive.value;

      // close dialog
      Get.back();

      // show success dialog
      CustomSnackbar.successSnackbar(title: "Success", message: "Data updated");

      // stop loading
      isLoading.value = false;
    } catch (e) {
      // stop loading
      isLoading.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error", message: "Please try again later");
    }
  }

  // set employe name to text controller
  void setEmployeNameToController(String employeName) {
    profileName.text = employeName;
  }

  // set branch data to text controller
  void setBranchDataToController(String branchNamee, branchPhoneNoo) {
    branchName.text = branchNamee;
    branchPhoneNumber.text = branchPhoneNoo;
  }

  void setMerchantDataToController() {
    restaurantName.text = merchantNameActive.value;
  }

  // init profile data if controller active
  void initProfileData() {
    String employeName = localStorage.read('employeNameActive');
    String employeID = localStorage.read('employeIDActive');
    String employeRole = localStorage.read('employeRoleIDActive');
    String employeEmail = localStorage.read('employeEmailActive');

    String branchName = localStorage.read('branchNameActive');
    String branchID = localStorage.read('branchIDActive');
    String branchAddress = localStorage.read('branchAddressActive');
    String branchDialCode = localStorage.read('branchDialCodeActive');
    String branchPhone = localStorage.read('branchPhoneActive');

    employeNameActive.value = employeName;
    employeIDActive.value = employeID;
    employeRoleActive.value = employeRole;
    employeEmailActive.value = employeEmail;

    branchNameActive.value = branchName;
    branchIDActive.value = branchID;
    branchAddressActive.value = branchAddress;
    branchDialCodeActive.value = branchDialCode;
    branchPhoneActive.value = branchPhone;
  }

  // change index navigation in setting page
  void changeIndex(index) {
    selectedIndex.value = index;
  }

  // view content sentting
  Widget viewContentInAccordanceIndex() {
    if (selectedIndex.value == 0) {
      return const ProfilePage();
    } else if (selectedIndex.value == 1) {
      return const AboutRestaurantPage();
    } else if (selectedIndex.value == 2) {
      return const AboutOutletPage();
    } else if (selectedIndex.value == 3) {
      return const Flexible(flex: 3, child: SizedBox());
    } else if (selectedIndex.value == 4) {
      return const PinAndPasswordPage();
    } else if (selectedIndex.value == 5) {
      return const ResetDataPage();
    } else if (selectedIndex.value == 6) {
      return const Flexible(flex: 3, child: SizedBox());
    } else if (selectedIndex.value == 7) {
      return const Flexible(flex: 3, child: SizedBox());
    } else if (selectedIndex.value == 8) {
      return const Flexible(flex: 3, child: SizedBox());
    } else if (selectedIndex.value == 9) {
      return const Flexible(flex: 3, child: SizedBox());
    } else {
      return const Flexible(flex: 3, child: SizedBox());
    }
  }
}
