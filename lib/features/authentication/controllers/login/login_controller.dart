import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/personalization/controllers/merchant_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/popups/loader.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Varibale
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(MerchantController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  // Login
  Future<void> emailAndPasswordLogin() async {
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
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value == true) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using email and password
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Move to verify email screen
      AuthenticationRepository.instance.screenRedirect();
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

  // Google login
  Future<void> googleSignIn() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog();

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // google auth
      final userCredential =
          await AuthenticationRepository.instance.loginWithGoogle();

      // save the record
      await userController.saveMerchant(userCredential);

      // remove loader
      TFullScreenLoader.stopLoading();
    } catch (e) {
      CustomSnackbar.errorSnackbar(title: 'Oh snap', message: e.toString());
    }
  }
}
