import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/data/repositories/category/category_repository.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/category_model.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  // call menu repository
  final categoryRepository = Get.put(CategoryRepository());
  // get storage
  final localStorage = GetStorage();

  // variable
  GlobalKey<FormState> categoryFormkey = GlobalKey();
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoading = false.obs;
  final categoryName = TextEditingController();
  final searchCategory = TextEditingController();
  RxString selectedCategoryID = "".obs;
  final List<String> dataColumnLabel = ["No", "name".tr, "action".tr];
  RxList<CategoryModel> allCategory = <CategoryModel>[].obs;
  RxList<CategoryModel> allCategoryToTable = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchSpesificMenufromBranchRecord();
    super.onInit();
  }

  // get all spresifik category in branch active
  Future<void> fetchSpesificMenufromBranchRecord() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    try {
      // show loading
      isLoading.value = true;
      // pick data
      final category = await categoryRepository.getAllCategoryRecord();
      // asign branch
      allCategory.assignAll(category.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());
      allCategoryToTable.assignAll(category.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());
    } catch (e) {
      // stop loading
      isLoading.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data category", message: "Please try again later");
    } finally {
      // stop loading
      isLoading.value = false;
    }
  }

  // delete category
  Future<void> deleteCategoryRecord(String categoryID) async {
    try {
      // show loading
      isLoadingDelete.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingDelete.value = false;
        return;
      }

      // call controller category repository
      final categoryRepository = Get.put(CategoryRepository());

      // delete category data in the firebase database
      await categoryRepository.deleteCategoryRecord(categoryID);

      // back to category screen
      Get.back();

      await fetchSpesificMenufromBranchRecord();

      // stop loading
      isLoadingDelete.value = false;
    } catch (e) {
      // stop loading
      isLoadingDelete.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error delete category", message: "Please try again later");
    }
  }

  // save category in firebase
  Future<void> saveCategoryRecord() async {
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
      if (!categoryFormkey.currentState!.validate()) {
        isLoadingAdd.value = false;
        return;
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newCategory = CategoryModel(
        categoryID: "ctg-$genericID",
        categoryName: categoryName.value.text.trim(),
        branchID: branchIDActive,
        merchantID: AuthenticationRepository.instance.authUser!.uid,
      );
      // call controller category repository
      final categoryRepository = Get.put(CategoryRepository());
      // Save category data in the firebase database
      await categoryRepository.saveCategory(newCategory);

      categoryName.clear();

      // back to category screen
      Get.back();

      await fetchSpesificMenufromBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Category added", message: "Category success added");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save category", message: "Please try again later");
    }
  }

// update role in firebase
  Future<void> updateCategoryRecord(String categoryID) async {
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
      if (!categoryFormkey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }

      // put data in model
      final updateCategory = CategoryModel(
        categoryID: categoryID,
        categoryName: categoryName.value.text.trim(),
        branchID: branchIDActive,
        merchantID: AuthenticationRepository.instance.authUser!.uid,
      );

      // call controller category repository
      final categoryRepository = Get.put(CategoryRepository());
      // Save category data in the firebase database
      await categoryRepository.updatCategory(updateCategory);

      categoryName.clear();

      // back to branch screen
      Get.back();

      await fetchSpesificMenufromBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Category updated", message: "Category success updated");

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error update category", message: "Please try again later");
    }
  }

  // orderirng branch data by search
  void orderBySearch() async {
    List<CategoryModel> filterData({
      required List<CategoryModel> data,
      required String namaSearchField,
    }) {
      return data
          .where((element) => element.categoryName
              .trim()
              .toLowerCase()
              .contains(
                  searchCategory.value.text.toString().trim().toLowerCase()))
          .toList(growable: false);
    }

    if (searchCategory.value.text.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<CategoryModel> updateData = filterData(
          data: allCategory, namaSearchField: searchCategory.value.text);
      allCategoryToTable.assignAll(updateData);
    } else {
      allCategoryToTable.assignAll(allCategory);
    }
  }

  // update branch
  Future<void> initializeDataUpdateToController(
      String categoryIDData, String categoryNameData) async {
    selectedCategoryID.value = categoryIDData;
    categoryName.text = categoryNameData;
  }
}
