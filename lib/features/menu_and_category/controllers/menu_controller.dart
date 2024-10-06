import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/data/repositories/firebase_storage/image/firebase_storage_image_repository.dart';
import 'package:restaurant_bukuku/data/repositories/menu/menu_repository.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/menu_model.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class MenuProductController extends GetxController {
  // call menu repository
  final menuRepository = Get.put(MenuRepository());
  // call controller Image ffirabse storage repository
  final firebaseStorageImageRepository =
      Get.put(ImageFirebaseStorageRepository());
  // get storage
  final localStorage = GetStorage();

  // variable
  GlobalKey<FormState> menuFormkey = GlobalKey();
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool allowFlexiblePrice = false.obs;
  RxString selectedCategoryFilter = "".obs;
  RxString selectedMenuID = "".obs;
  RxString selectedImage = "".obs;
  final searchMenu = TextEditingController();
  final menuName = TextEditingController();
  final menuCategory = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final RxList addons = [].obs;
  final RxList receipe = [].obs;
  final List<String> dataColumnLabel = [
    "No",
    "name".tr,
    "Price",
    "Tersedia untuk",
    "action".tr
  ];

  final RxString selectedCategory = "".obs;

  Uint8List webImageMenu = Uint8List(8);
  Rx<File?> imageMenu = Rx<File?>(null);
  Rx<XFile?> imageMenuForUpload = Rx<XFile?>(null);

  RxList<MenuModel> allMenu = <MenuModel>[].obs;
  RxList<MenuModel> allMenuToTable = <MenuModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpesificMenufromBranchRecord();
  }

  // Get restaurant image from gallery
  Future<void> getMenuImageFromGallery() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageMenuForUpload.value = image;
        var selected = File(image.path);

        imageMenu.value = selected;
        Get.back();
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageMenuForUpload.value = image;
        var f = await image.readAsBytes();

        webImageMenu = f;
        imageMenu.value = File('a');

        Get.back();
      }
    }
  }

  // Get restaurant image from camera
  Future<void> getMenuImageFromCamera() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageMenuForUpload.value = image;
        var selected = File(image.path);

        imageMenu.value = selected;
        Get.back();
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageMenuForUpload.value = image;
        var f = await image.readAsBytes();

        webImageMenu = f;
        imageMenu.value = File('a');
        Get.back();
      }
    }
  }

  // fetch all menu in spesific branch
  Future<void> fetchSpesificMenufromBranchRecord() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final menu = await menuRepository.getAllMenuRecord();
      // asign branch
      allMenu.assignAll(menu.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());
      allMenuToTable.assignAll(menu.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());
    } catch (e) {
      // stop loading
      isLoadingGet.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data menu", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // delete menu
  Future<void> deleteMenuRecord(String menuID) async {
    final createOrderController = Get.put(CreateOrderController());
    try {
      // show loading
      isLoadingDelete.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingDelete.value = false;
        return;
      }

      // call controller menu repository
      final menuRepository = Get.put(MenuRepository());

      // delete category data in the firebase database
      await menuRepository.deleteMenuRecord(menuID);

      description.clear();
      price.clear();
      menuName.clear();
      menuCategory.clear();
      description.clear();
      addons.clear();
      receipe.clear();
      allowFlexiblePrice.value = false;
      imageMenu.value = null;
      imageMenuForUpload.value = null;

      // back to category screen
      Get.back();

      await fetchSpesificMenufromBranchRecord();
      createOrderController.fetchSpecificMenuFromBranchRecord();

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

  // save menu in firebase
  Future<void> saveMenuRecord() async {
    final createOrderController = Get.put(CreateOrderController());

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
      if (!menuFormkey.currentState!.validate()) {
        isLoadingAdd.value = false;
        return;
      }

      // variable url image menu
      String urlMenu = "";

      // cek the image is null or not , if not continue to upload firebase storage
      if (imageMenuForUpload.value != null) {
        urlMenu = await firebaseStorageImageRepository.uploadImage(
            "Menus/", imageMenuForUpload.value!);
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newMenu = MenuModel(
        menuID: "mnu-$genericID",
        menuName: menuName.value.text.trim(),
        branchID: branchIDActive,
        merchantID: AuthenticationRepository.instance.authUser!.uid,
        description: description.text.trim(),
        menuImage: urlMenu,
        price: double.parse(price.text.trim()),
        category: menuCategory.text.trim(),
        addons: [],
        recipes: [],
        allowFlexiblePrice: allowFlexiblePrice.value,
      );
      // call controller menu repository
      final menuRepository = Get.put(MenuRepository());
      // Save menu data in the firebase database
      await menuRepository.saveMenu(newMenu);

      description.clear();
      price.clear();
      menuName.clear();
      menuCategory.clear();
      description.clear();
      addons.clear();
      receipe.clear();
      allowFlexiblePrice.value = false;
      imageMenu.value = null;
      imageMenuForUpload.value = null;
      urlMenu = '';

      // back to menu screen
      Get.back(id: 2);

      await fetchSpesificMenufromBranchRecord();
      createOrderController.fetchSpecificMenuFromBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Menu added", message: "Menu success added");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save menu", message: "Please try again later");
    }
  }

// update menu in firebase
  Future<void> updateMenuRecord(String menuID) async {
    final createOrderController = Get.put(CreateOrderController());
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
      if (!menuFormkey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }
      // variable url image menu
      String urlMenu = "";

      // cek the image is null or not , if not continue to upload firebase storage
      if (imageMenuForUpload.value != null) {
        urlMenu = await firebaseStorageImageRepository.uploadImage(
            "Menus/", imageMenuForUpload.value!);
      } else {
        urlMenu = selectedImage.value;
      }
      // put data in model
      final updateMenuRecord = MenuModel(
        menuID: menuID,
        menuName: menuName.value.text.trim(),
        branchID: branchIDActive,
        merchantID: AuthenticationRepository.instance.authUser!.uid,
        description: description.text.trim(),
        menuImage: urlMenu,
        price: double.parse(price.text.trim()),
        category: menuCategory.text.trim(),
        addons: [],
        recipes: [],
        allowFlexiblePrice: allowFlexiblePrice.value,
      );

      // call controller menu repository
      final menuRepository = Get.put(MenuRepository());
      // Save menu data in the firebase database
      await menuRepository.updateMenu(updateMenuRecord);

      description.clear();
      price.clear();
      menuName.clear();
      menuCategory.clear();
      description.clear();
      addons.clear();
      receipe.clear();
      allowFlexiblePrice.value = false;
      imageMenu.value = null;
      imageMenuForUpload.value = null;
      urlMenu = '';

      // back to branch screen
      Get.back(id: 2);

      await fetchSpesificMenufromBranchRecord();

      createOrderController.fetchSpecificMenuFromBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Menu updated", message: "Menu success updated");

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error update menu", message: "Please try again later");
    }
  }

  // orderirng branch data by search
  void orderBySearch() async {
    List<MenuModel> filterData({
      required List<MenuModel> data,
      required String namaSearchField,
      required String nameCategory,
    }) {
      return data
          .where((element) => element.menuName
              .trim()
              .toLowerCase()
              .contains(searchMenu.value.text.toString().trim().toLowerCase()))
          .where((element) => element.category.trim().toLowerCase().contains(
              selectedCategoryFilter.value.toString().trim().toLowerCase()))
          .toList(growable: false);
    }

    if (searchMenu.value.text.isNotEmpty ||
        selectedCategoryFilter.value.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<MenuModel> updateData = filterData(
          data: allMenu,
          namaSearchField: searchMenu.value.text,
          nameCategory: selectedCategoryFilter.value);
      allMenuToTable.assignAll(updateData);
    } else {
      allMenuToTable.assignAll(allMenu);
    }
  }

  // update branch
  Future<void> initializeDataUpdateToController(
      String menuIDData,
      String menuNameData,
      String menuImageData,
      String menuCategoryData,
      bool allowFlexiblePriceData,
      String desciptionData,
      double priceData,
      List addonsData,
      List recipesData) async {
    selectedMenuID.value = menuIDData;
    menuName.text = menuNameData;
    menuCategory.text = menuCategoryData;
    allowFlexiblePrice.value = allowFlexiblePriceData;
    description.text = desciptionData;
    price.text = priceData.toString();
    addons.assignAll(addonsData);
    recipesData.assignAll(recipesData);
    selectedImage.value = menuImageData;
  }
}
