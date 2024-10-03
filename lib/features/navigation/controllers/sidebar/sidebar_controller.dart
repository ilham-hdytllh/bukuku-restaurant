import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/roles/roles_repository.dart';
import 'package:restaurant_bukuku/features/employe/models/roles/role_model.dart';
import 'package:restaurant_bukuku/features/navigation/controllers/appbar/appbar_controller.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class SidebarController extends GetxController {
  static SidebarController get instance => Get.find();

  final appbarController = Get.put(AppBarController());
  final roleRepository = Get.put(RoleRepository());
  // Varibale
  RxBool isLoading = false.obs;
  RxInt index = 0.obs;
  RxString roleActive = "".obs;
  RxMap permission = {}.obs;
  final ScrollController scrollController = ScrollController();
  RxList<RoleModel> allRoles = <RoleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllRoleRecord();
  }

  // Get all role record
  Future<void> fetchAllRoleRecord() async {
    try {
      // show loading
      isLoading.value = true;
      // pick data
      final roles = await roleRepository.getAllRolesRecord();
      // asign branch
      allRoles.assignAll(roles);

      // get role active
      roleActive.value = GetStorage().read('employeRoleIDActive') ?? "";

      //filter role where in role
      RoleModel filteredData = allRoles
          .firstWhere((element) => element.roleName == roleActive.value);

      permission.addAll(
        filteredData.permissions,
      );
    } catch (e) {
      // stop loading
      isLoading.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data role", message: "Please try again later");
    } finally {
      // stop loading
      isLoading.value = false;
    }
  }

  // Fungsi update page
  void updatePage(int newIndex) {
    index.value = newIndex;
    switch (newIndex) {
      case 0:
        appbarController.appBarTitle.value = "New Order";

      case 1:
        appbarController.appBarTitle.value = "Order";

      case 2:
        appbarController.appBarTitle.value = "Menu";

      case 3:
        appbarController.appBarTitle.value = "Promotion";

      case 4:
        appbarController.appBarTitle.value = "Staff";

      case 5:
        appbarController.appBarTitle.value = "Inventory";

      case 6:
        appbarController.appBarTitle.value = "Branch";

      case 7:
        appbarController.appBarTitle.value = "Report";

      case 8:
        appbarController.appBarTitle.value = "Customer";
      case 9:
        appbarController.appBarTitle.value = "Table";

      default:
    }
  }
}
