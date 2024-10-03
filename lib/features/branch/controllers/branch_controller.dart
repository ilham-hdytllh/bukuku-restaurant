import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/data/repositories/branch/branch_repository.dart';
import 'package:restaurant_bukuku/features/branch/models/branch_model.dart';
import 'package:restaurant_bukuku/features/employe/controller/employes/employee_controller.dart';
import 'package:restaurant_bukuku/features/navigation/screens/main_navigation/main_navigation.dart';
import 'package:restaurant_bukuku/features/system/controller/address_from_map/address_from_map.dart';
import 'package:restaurant_bukuku/features/system/controller/dialcode/dialcode_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/popups/loader.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class BranchController extends GetxController {
  static BranchController get instance => Get.find();

  final branchRepository = Get.put(BranchRepository());
  final employeController = Get.put(EmployeController());
  final localStorage = GetStorage();
  // put address form map controller
  final addressFromMapController = Get.put(AddressFromMapController());

  // varibale
  GlobalKey<FormState> branchFormKey = GlobalKey();
  final deviceStorage = GetStorage();
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
  final RxBool isLoadingNavigate = false.obs;
  final searchBranch = TextEditingController().obs;
  final branchName = TextEditingController().obs;
  final branchPhoneNo = TextEditingController().obs;
  final branchEmail = TextEditingController().obs;

  final RxString selectedBranchID = "".obs;
  RxList<BranchModel> allBranchesFilteredCustomerID = <BranchModel>[].obs;
  RxList<BranchModel> searchBranches = <BranchModel>[].obs;
  RxList<BranchModel> allBranches = <BranchModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpesificEmployeBranchRecord();
    fetchAllBranchRecord();
  }

  // Get all branch record
  Future<void> fetchAllBranchRecord() async {
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final branches = await branchRepository.getAllBranchRecord();
      // asign branch
      allBranches.assignAll(branches);
      searchBranches.assignAll(branches);
    } catch (e) {
      // stop loading
      isLoadingGet.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data branch", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // Branch spresifik account employe
  Future<void> fetchSpesificEmployeBranchRecord() async {
    try {
      // show loading
      isLoadingGet.value = true;

      // pick data
      final branches = await branchRepository.getAllBranchRecord();

      // asign branch
      if (employeController.selectedEmployeRole.value == "master") {
        allBranchesFilteredCustomerID.assignAll(branches);
      } else {
        allBranchesFilteredCustomerID.assignAll(branches.where((element) {
          return element.branchID
              .toString()
              .trim()
              .toLowerCase()
              .contains(selectedBranchID.value.toString().trim().toLowerCase());
        }).toList());
      }
    } catch (e) {
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data branch", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // orderirng branch data by search
  void orderBySearch() async {
    List<BranchModel> filterData({
      required List<BranchModel> data,
      required String namaSearchField,
    }) {
      return data
          .where((element) => element.branchName.trim().toLowerCase().contains(
              searchBranch.value.text.toString().trim().toLowerCase()))
          .toList(growable: false);
    }

    if (searchBranch.value.text.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<BranchModel> updateData = filterData(
          data: allBranches, namaSearchField: searchBranch.value.text);
      searchBranches.assignAll(updateData);
    } else {
      searchBranches.assignAll(allBranches);
    }
  }

  // Set id customer selected and navigate to cek pin screen
  void setBranchNameandNavigateToMainNavigation(
      String branchID,
      String branchName,
      String branchAddress,
      String branchDialCode,
      String branchPhone) async {
    // get storage
    final localStorage = GetStorage();

    // set false loading variable
    isLoadingNavigate.value = true;

    // Show loading
    TFullScreenLoader.openLoadingDialog();

    // save in local storage branch name
    localStorage.write('branchNameActive', branchName);
    localStorage.write('branchIDActive', branchID);
    localStorage.write('branchAddressActive', branchAddress);
    localStorage.write('branchDialCodeActive', branchDialCode);
    localStorage.write('branchPhoneActive', branchPhone);

    selectedBranchID.value = branchID;

    await Future.delayed(const Duration(seconds: 1));

    // set true loading variable
    isLoadingNavigate.value = false;

    // Stop loading
    TFullScreenLoader.stopLoading();

    // Method to save lastValidationPIN time
    await deviceStorage.write(
        'lastValidationPIN', DateTime.now().millisecondsSinceEpoch);

    // navigate no main navigation
    Get.offAll(const MainNavigation());
  }

  // save new branch to databse
  Future<void> saveBranchToFirestore() async {
    // call dialcode controller
    final dialCodeController = Get.put(DialCodeController());
    try {
      // show loading
      isLoadingAdd.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingUpdate.value = false;
        return;
      }

      // form validation
      if (!branchFormKey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newBranch = BranchModel(
        merchantID: AuthenticationRepository.instance.authUser!.uid,
        branchID: "bch-$genericID",
        branchAddress:
            addressFromMapController.addressFromMap.value.text.trim(),
        branchName: branchName.value.text.trim(),
        branchDialCode: dialCodeController.selectedCodePhoneString.value,
        branchPhoneNo: branchPhoneNo.value.text.trim(),
        branchEmail: branchEmail.value.text.trim(),
      );
      // call controller branch repository
      final branchRepository = Get.put(BranchRepository());
      // Save branch data in the firebase database
      await branchRepository.saveBranch(newBranch);

      addressFromMapController.addressFromMap.value.clear();
      branchName.value.clear();
      branchEmail.value.clear();
      branchPhoneNo.value.clear();

      await fetchAllBranchRecord();

      // back to branch screen
      Get.back(id: 6);

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Branch added", message: "Branch success added");
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save branch", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingAdd.value = false;
    }
  }

  // save new branch to databse
  Future<void> updateBranchToFirestore(String branchID) async {
    final dialCodeController = Get.put(DialCodeController());
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
      if (!branchFormKey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }

      // put data in model
      final updateBranch = BranchModel(
        merchantID: AuthenticationRepository.instance.authUser!.uid,
        branchID: branchID,
        branchAddress:
            addressFromMapController.addressFromMap.value.text.trim(),
        branchName: branchName.value.text.trim(),
        branchDialCode: dialCodeController.selectedCodePhoneString.value,
        branchPhoneNo: branchPhoneNo.value.text.trim(),
        branchEmail: branchEmail.value.text.trim(),
      );
      // call controller branch repository
      final branchRepository = Get.put(BranchRepository());
      // Save branch data in the firebase database
      await branchRepository.updateBranch(updateBranch);

      addressFromMapController.addressFromMap.value.clear();
      branchName.value.clear();
      branchEmail.value.clear();
      branchPhoneNo.value.clear();

      // back to branch screen
      Get.back(id: 6);

      await fetchAllBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Branch added", message: "Branch success added");
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save branch", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingUpdate.value = false;
    }
  }

  // update branch
  Future<void> initializeDataUpdateToController(
      String branchIDData,
      String branchNameData,
      String branchAddressData,
      String branchDialCodeData,
      String branchPhoneNoData,
      String branchEmailData) async {
    final dialCodeContrller = Get.put(DialCodeController());
    dialCodeContrller.codePhoneString.value = branchDialCodeData;
    selectedBranchID.value = branchIDData;
    branchName.value.text = branchNameData;
    branchPhoneNo.value.text = branchPhoneNoData;
    branchEmail.value.text = branchEmailData;
    addressFromMapController.addressFromMap.value.text = branchAddressData;
  }

  // Branch spresifik account employe
  Future<void> deleteBranchRecord(String branchID) async {
    final employeController = Get.put(EmployeController());
    try {
      // show loading
      isLoadingDelete.value = true;

      // checking employe already in this branch or no
      bool checkEmployeInBranch = employeController.allEmploye.any((element) =>
          element.branchID.toLowerCase().trim() ==
          branchID.toLowerCase().trim());

      if (checkEmployeInBranch == true) {
        // close dialog
        Get.back();
        // eror if have employe in branch
        CustomSnackbar.errorSnackbar(
          title: "Cannot remove this branch",
          message:
              "Please remove all employe in this branch,before you remove this branch",
        );
      } else {
        // delete data
        await branchRepository.deleteBranchRecord(branchID);

        // close dialog
        Get.back();

        await fetchAllBranchRecord();
      }
    } catch (e) {
      // stop loading
      isLoadingDelete.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data branch", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingDelete.value = false;
    }
  }
}
