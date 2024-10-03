import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/data/repositories/dummy_data/role_dummy_data.dart';
import 'package:restaurant_bukuku/data/repositories/merchant/merchant_repository.dart';
import 'package:restaurant_bukuku/data/repositories/roles/roles_repository.dart';
import 'package:restaurant_bukuku/features/authentication/models/merchant_model.dart';
import 'package:restaurant_bukuku/features/authentication/screens/create_pin/create_pin_screen.dart';
import 'package:restaurant_bukuku/features/employe/models/roles/role_model.dart';
import 'package:restaurant_bukuku/features/system/controller/dialcode/dialcode_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/popups/loader.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Varibale
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  RxString usernameBackup = "".obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  Rx<TextEditingController> searchDialCode = TextEditingController().obs;

  // Singup
  Future<void> singupWithEmailPassword() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog();

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user in the firebase auth & save data in firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      // call dialcode controller
      final dialCodeController = Get.put(DialCodeController());

      // put data in model
      final newUser = MerchantModel(
        merchantID: userCredential.user!.uid,
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber:
            "${dialCodeController.selectedCodePhoneString.value}${phoneNumber.text.trim()}",
        restaurantAddress: "",
        restaurantCurrency: "",
        restaurantLogo: "",
        restaurantName: "",
        restaurantType: [],
      );
      // call controller merchant repository
      final userRepository = Get.put(MerchantRepository());
      // Save auth user data in the firebase database
      await userRepository.saveMerchantRecord(newUser);

      // create role
      for (var data in rolesStaticList) {
        // create generic id from datetime epoch
        final String genericID =
            DateTime.now().millisecondsSinceEpoch.toString();

        RoleModel roleModel = RoleModel(
          roleID: "role-$genericID",
          roleName: data["roleName"],
          permissions: data["permissions"],
        );

        // call controller roles repository
        final roleRepository = Get.put(RoleRepository());

        // Save roles user data in the firebase database
        await roleRepository.saveRole(roleModel);
      }

      // save username to variable controller to use in starter setup
      usernameBackup.value = username.text.trim();

      // Move to create pin and starting setup
      Get.offAll(() => const CreatePIN());
    } catch (e) {
      // show message generic eror to user
      CustomSnackbar.errorSnackbar(title: "Error", message: e.toString());
      // remove loader
      TFullScreenLoader.stopLoading();
    } finally {
      // remove loader
      // TFullScreenLoader.stopLoading();
    }
  }
}
