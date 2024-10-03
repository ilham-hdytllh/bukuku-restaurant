import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/data/repositories/employe/employe_repository.dart';
import 'package:restaurant_bukuku/features/branch/controllers/branch_controller.dart';
import 'package:restaurant_bukuku/features/employe/models/employe/employe_model.dart';
import 'package:restaurant_bukuku/features/authentication/screens/create_pin/cek_pin_screen.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class EmployeController extends GetxController {
  static EmployeController get instance => Get.find();

  final employeRepository = Get.put(EmployeRepository());

  // varibale
  GlobalKey<FormState> employeFormkey = GlobalKey();
  RxBool hidePassword = true.obs;
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
  Rx<EmployeModel> employe = EmployeModel.empty().obs;
  RxList<EmployeModel> allEmploye = <EmployeModel>[].obs;
  RxList<EmployeModel> allEmployeToTable = <EmployeModel>[].obs;

  Rx<TextEditingController> searchEmploye = TextEditingController().obs;
  final employeName = TextEditingController();
  final employeEmail = TextEditingController();
  final employeRole = TextEditingController();
  final employePIN = TextEditingController();
  // varibale untuk auth
  RxString selectedEmployeID = "".obs;
  RxString selectedEmployeName = "".obs;
  RxString selectedEmployeRole = "".obs;
  RxString selectedEmployePIN = "".obs;

  @override
  void onInit() {
    employeRole.clear();
    fetchAllEmployeRecord();
    super.onInit();
  }

  // Get merchant record
  Future<void> fetchEmployeRecord() async {
    try {
      if (selectedEmployeID.isNotEmpty) {
        final employe =
            await employeRepository.getEmployeRecord(selectedEmployeID.value);
        this.employe(employe);
      } else {
        employe(EmployeModel.empty());
      }
    } catch (e) {
      employe(EmployeModel.empty());
    }
  }

  // Get all merchant record
  Future<void> fetchAllEmployeRecord() async {
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final employes = await employeRepository.getAllEmployeRecord();
      // asign employe
      allEmploye.assignAll(employes);
      allEmployeToTable.assignAll(employes);
    } catch (e) {
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data employe", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // Set id customer selected and navigate to cek pin screen
  void setEmployeIDandNavigateToBranch(String employeID, String employeName,
      String pin, String role, String branchID, String email) {
    final branchController = Get.put(BranchController());
    // get storage
    final localStorage = GetStorage();
    selectedEmployeID.value = employeID;
    selectedEmployeName.value = employeName;
    selectedEmployeRole.value = role;
    selectedEmployePIN.value = pin;
    branchController.selectedBranchID.value = branchID;

    // save in local storage branch name
    localStorage.write('employeNameActive', employeName);
    localStorage.write('employeIDActive', employeID);
    localStorage.write('employeRoleIDActive', role);
    localStorage.write('employeEmailActive', email);

    // branchController.allBranchesFilteredCustomerID();
    Get.to(const CekPinScreen());
  }

  // delete customer
  Future<void> deleteEmployeRecord(String employeID, String role) async {
    try {
      // show loading
      isLoadingDelete.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingDelete.value = false;
        return;
      }

      // call controller employe repository
      final employeRepository = Get.put(EmployeRepository());

      if (role == "master") {
        isLoadingDelete.value = false;
        Get.back();
        // error message
        CustomSnackbar.errorSnackbar(
            title: "Error delete employe",
            message: "Cannot remove default account !");
        return;
      }
      // delete employe data in the firebase database
      await employeRepository.deleteEmployeRecord(employeID);

      // back to branch screen
      Get.back();

      await fetchAllEmployeRecord();

      // stop loading
      isLoadingDelete.value = false;
    } catch (e) {
      // stop loading
      isLoadingDelete.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error delete employe", message: "Please try again later");
    }
  }

  // save customer in firebase
  Future<void> saveEmployeRecord() async {
    final localStorage = GetStorage();
    // set value from local to variable
    String branchIDActive = localStorage.read('branchIDActive') ?? "";
    try {
      // show loading
      isLoadingAdd.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingAdd.value = false;
        return;
      }

      // form validation
      if (!employeFormkey.currentState!.validate()) {
        isLoadingAdd.value = false;
        return;
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newEmploye = EmployeModel(
        employeID: "emp-$genericID",
        employeName: employeName.value.text.trim(),
        employeEmail: employeEmail.value.text.trim(),
        role: employeRole.value.text.trim(),
        pin: employePIN.value.text.trim(),
        branchID: branchIDActive,
        merchantID: AuthenticationRepository.instance.authUser!.uid,
      );
      // call controller employe repository
      final employeRepository = Get.put(EmployeRepository());
      // Save employe data in the firebase database
      await employeRepository.saveEmploye(newEmploye);

      employeEmail.clear();
      employeRole.clear();
      employePIN.clear();
      employeName.clear();

      // back to employe screen
      Get.back(id: 4);

      await fetchAllEmployeRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Employe added", message: "Employe success added");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save Employe", message: "Please try again later");
    }
  }

// update role in firebase
  Future<void> updateEmployeRecord(String employeID) async {
    final localStorage = GetStorage();
    // set value from local to variable
    String branchIDActive = localStorage.read('branchIDActive') ?? "";
    try {
      // show loading
      isLoadingUpdate.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingUpdate.value = false;
        return;
      }

      // form validation
      if (!employeFormkey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }

      // put data in model
      final updateEmploye = EmployeModel(
        employeID: employeID,
        employeName: employeName.value.text.trim(),
        employeEmail: employeEmail.value.text.trim(),
        role: employeRole.value.text.trim(),
        pin: employePIN.value.text.trim(),
        branchID: branchIDActive,
        merchantID: AuthenticationRepository.instance.authUser!.uid,
      );

      // call controller employe repository
      final employeRepository = Get.put(EmployeRepository());
      // Save employe data in the firebase database
      await employeRepository.updateEmploye(updateEmploye);

      employeEmail.clear();
      employeRole.clear();
      employePIN.clear();
      employeName.clear();

      // back to branch screen
      Get.back(id: 4);

      await fetchAllEmployeRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Employe updated", message: "Employe success updated");

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error update employe", message: "Please try again later");
    }
  }

  // orderirng branch data by search
  void orderBySearch() async {
    List<EmployeModel> filterData({
      required List<EmployeModel> data,
      required String namaSearchField,
      required String roleSearchField,
    }) {
      return data
          .where((element) => element.employeName.trim().toLowerCase().contains(
              searchEmploye.value.text.toString().trim().toLowerCase()))
          .where((element) => element.role
              .trim()
              .toLowerCase()
              .contains(employeRole.value.text.toString().trim().toLowerCase()))
          .toList(growable: false);
    }

    if (searchEmploye.value.text.isNotEmpty ||
        employeRole.value.text.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<EmployeModel> updateData = filterData(
          data: allEmploye,
          namaSearchField: searchEmploye.value.text,
          roleSearchField: employeRole.value.text);
      allEmployeToTable.assignAll(updateData);
    } else {
      allEmployeToTable.assignAll(allEmploye);
    }
  }

  // set to update view
  void setVariableToUpdate(
    String employeIDData,
    String employeNameData,
    String employeEmailData,
    String employeRoleData,
    String employePinData,
  ) {
    selectedEmployeID.value = employeIDData;
    employeName.text = employeNameData;
    employeEmail.text = employeEmailData;
    employeRole.text = employeRoleData;
    employePIN.text = employePinData;
  }
}
