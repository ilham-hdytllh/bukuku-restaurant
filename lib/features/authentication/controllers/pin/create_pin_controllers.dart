import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/screens/create_pin/confirm_pin_screen.dart';
import 'package:restaurant_bukuku/features/authentication/screens/select_branch/select_branch_screen.dart';
import 'package:restaurant_bukuku/features/authentication/screens/starting_setup/starting_setup_screen.dart';
import 'package:restaurant_bukuku/features/employe/controller/employes/employee_controller.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class PinController extends GetxController {
  static PinController get instance => Get.find();

  final employeController = Get.put(EmployeController());

  // variable
  Rx<TextEditingController> pinController = TextEditingController().obs;
  Rx<TextEditingController> pinCreate = TextEditingController().obs;
  Rx<TextEditingController> pinConfirm = TextEditingController().obs;
  RxBool hiddenPIN = true.obs;
  Rx<String> pinCreated = "".obs;
  Rx<String> confirmPIN = "".obs;

  void navigateToStartingSetup(String pin) {
    confirmPIN.value = pin;

    if (pinCreated.value == confirmPIN.value) {
      Get.to(const StartingSetup());
      pinConfirm.value.clear();
    } else {
      pinConfirm.value.clear();
      CustomSnackbar.errorSnackbar(
          title: "Confirm Tidak Sesuai",
          message:
              "Pastikan confirm PIN sama dengan PIN yang anda buat sebelumnya.");
    }
  }

  void navigateToConfirmPin(String pin) {
    pinCreated.value = pin;
    pinCreate.value.clear();
    Get.to(const ConfirmPinScreen());
  }

  void pinValidation(String pin) {
    if (employeController.selectedEmployePIN.value == pin) {
      pinController.value.clear();

      // navigate if pin true
      Get.to(const SelectBranchScreen());
    } else {
      pinController.value.clear();
      // alert error if pin false
      CustomSnackbar.errorSnackbar(
          title: "PIN is wrong", message: "Please input your fix PIN code.");
    }
  }
}
