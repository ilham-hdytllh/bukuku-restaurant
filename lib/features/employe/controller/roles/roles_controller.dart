import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/roles/roles_repository.dart';
import 'package:restaurant_bukuku/features/employe/models/roles/role_model.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class RoleController extends GetxController {
  static RoleController get instance => Get.find();

  final roleRepository = Get.put(RoleRepository());

  // variable
  RxBool updateActive = false.obs;
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxString selectedRoleID = "".obs;
  GlobalKey<FormState> roleFormKey = GlobalKey();
  final roleName = TextEditingController().obs;
  RxString roleActive = "".obs;
  RxMap<String, dynamic> permissionSelected = <String, dynamic>{
    "branch": false,
    "create_order": false,
    "customer": false,
    "inventory": false,
    "menu": false,
    "order": false,
    "promotion": false,
    "report": false,
    "staff": false,
    "table": false,
  }.obs;

  RxList<RoleModel> allRoles = <RoleModel>[].obs;

  @override
  void onInit() {
    fetchAllRoleRecord();
    resetPermissionSelected();
    super.onInit();
  }

  bool anyPermissionSelected() {
    return permissionSelected.containsValue(true);
  }

  // Get all role record
  Future<void> fetchAllRoleRecord() async {
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final roles = await roleRepository.getAllRolesRecord();
      // asign branch
      allRoles.assignAll(roles);

      await Future.delayed(const Duration(seconds: 1));

      // stop loading
      isLoadingGet.value = false;
    } catch (e) {
      // stop loading
      isLoadingGet.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data role", message: "Please try again later");
    }
  }

  // delete role
  Future<void> deleteRoleRecord(String roleID) async {
    try {
      // show loading
      isLoadingDelete.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingDelete.value = false;
        return;
      }

      // call controller branch repository
      final roleRepository = Get.put(RoleRepository());
      // Save branch data in the firebase database
      await roleRepository.deleteRole(roleID);

      // back to branch screen
      Get.back();

      await fetchAllRoleRecord();

      // stop loading
      isLoadingDelete.value = false;
    } catch (e) {
      // stop loading
      isLoadingDelete.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error delete role", message: "Please try again later");
    }
  }

  // save role in firebase
  Future<void> saveRoleRecord() async {
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
      if (!roleFormKey.currentState!.validate()) {
        isLoadingAdd.value = false;
        return;
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newRole = RoleModel(
        roleID: "role-$genericID",
        roleName: roleName.value.text.toLowerCase().trim(),
        permissions: permissionSelected,
      );
      // call controller branch repository
      final roleRepository = Get.put(RoleRepository());
      // Save branch data in the firebase database
      await roleRepository.saveRole(newRole);

      await fetchAllRoleRecord();

      roleName.value.clear();

      resetPermissionSelected();

      // back to branch screen
      Get.back(id: 6);

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Role added", message: "Branch success added");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save role", message: "Please try again later");
    }
  }

  // set to update view
  void setUpdateView(
      String rolName, String roleID, Map<String, dynamic> permission) {
    selectedRoleID.value = roleID;
    roleName.value.text = rolName;
    permissionSelected.addAll(permission);
    updateActive.value = true;
  }

  // cancel to update view
  void cancelUpdateView() {
    selectedRoleID.value = "";
    roleName.value.clear();
    resetPermissionSelected();
    updateActive.value = false;
  }

  // save role in firebase
  Future<void> updateRoleRecord() async {
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
      if (!roleFormKey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }

      // put data in model
      final updateRole = RoleModel(
        roleID: selectedRoleID.value,
        roleName: roleName.value.text.toLowerCase().trim(),
        permissions: permissionSelected,
      );
      // call controller branch repository
      final roleRepository = Get.put(RoleRepository());
      // Save branch data in the firebase database
      await roleRepository.updateRole(updateRole);

      roleName.value.clear();

      resetPermissionSelected();

      await fetchAllRoleRecord();

      updateActive.value = false;

      // back to branch screen
      Get.back(id: 6);

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Role updated", message: "Branch success added");

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error update role", message: "Please try again later");
    }
  }

  void resetPermissionSelected() {
    permissionSelected.addAll({
      "branch": false,
      "create_order": false,
      "customer": false,
      "inventory": false,
      "menu": false,
      "order": false,
      "promotion": false,
      "report": false,
      "staff": false,
      "table": false,
    }.obs);
  }
}
