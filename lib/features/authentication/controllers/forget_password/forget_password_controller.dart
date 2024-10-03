import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/authentication/screens/password_configuration/reset_password_tablet.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/popups/loader.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();

  // send reset password email
  sendPasswordResetEmail() async {
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
      if (!forgetPasswordKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // send email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());
      // remove loader
      TFullScreenLoader.stopLoading();
      // show  success
      CustomSnackbar.successSnackbar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password');

      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackbar(title: "Oh Snap", message: e.toString());
    }
  }

  // resend reset password
  resendPasswordResetEmail(String email) async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog();

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      // remove loader
      TFullScreenLoader.stopLoading();
      // show  success
      CustomSnackbar.successSnackbar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password');
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackbar(title: "Oh Snap", message: e.toString());
    }
  }
}
