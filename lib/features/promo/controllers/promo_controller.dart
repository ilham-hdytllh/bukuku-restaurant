import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/category/category_repository.dart';
import 'package:restaurant_bukuku/data/repositories/menu/menu_repository.dart';
import 'package:restaurant_bukuku/data/repositories/promo/promo_repository.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/menu_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/category_model.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/menu_model.dart';
import 'package:restaurant_bukuku/features/promo/models/promo_model.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class PromoController extends GetxController {
  static PromoController get instance => Get.find();

  final menuController = Get.put(MenuProductController());
  final menuRepository = Get.put(MenuRepository());
  final categoryRepository = Get.put(CategoryRepository());
  final promoRepository = Get.put(PromoRepository());

  final localStorage = GetStorage();

  // variable
  GlobalKey<FormState> promoGeneral = GlobalKey();
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;

  RxBool selectedPromotionHour = false.obs;
  RxString selectedPromoID = "".obs;
  RxString selectedBranchID = "".obs;
  RxString selectedPromoType = "general".obs;
  RxString selectedDiscountType = "amount".obs;
  RxString promotionActiveType = "always".obs;
  RxBool appliesWithMultiplePurchases = false.obs;
  final multiplePurchasesQty = TextEditingController();
  final searchMenu = TextEditingController().obs;
  final searchCategory = TextEditingController().obs;
  final promoNameController = TextEditingController();
  final promoDescriptionController = TextEditingController();
  final discountAmountController = TextEditingController();
  final discountPercentController = TextEditingController();
  final maximumDiscountController = TextEditingController();
  final minimumPurchaseController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startHourController = TextEditingController();
  final endHourController = TextEditingController();

  RxList<PromoModel> allPromo = <PromoModel>[].obs;
  RxList<PromoModel> allPromoToView = <PromoModel>[].obs;
  RxList<MenuModel> allMenu = <MenuModel>[].obs;
  RxList<CategoryModel> allCategory = <CategoryModel>[].obs;
  RxList<MenuModel> allMenuInNotselectedMenuForPromo = <MenuModel>[].obs;
  RxList<CategoryModel> allCategoryInNotselectedCategoryForPromo =
      <CategoryModel>[].obs;
  RxList<MenuModel> selectedMenuForPromo = <MenuModel>[].obs;
  RxList<CategoryModel> selectedCategoryForPromo = <CategoryModel>[].obs;
  RxList<MenuModel> backupDataMenu = <MenuModel>[].obs;
  RxList<CategoryModel> backupDataCategory = <CategoryModel>[].obs;
  RxList selectedDays = [].obs;
  List<String> promoTableLabel = [
    "No",
    "Daftar Promo",
    "Tipe Promo",
    "Waktu Berlaku",
    "action".tr
  ];
  List<String> daysOfWeek = [
    "Every Monday",
    "Every Tuesday",
    "Every Wednesday",
    "Every Thursday",
    "Every Friday",
    "Every Saturday",
    "Every Sunday"
  ];

  RxString selectedPromotedProduct = "menu".obs;

  @override
  void onInit() {
    fetchSpesificPromofromBranchRecord();
    fetchSpesificMenufromBranchRecord();
    fetchSpesificCategoryfromBranchRecord();
    super.onInit();
  }

  // checking selected days empty or not
  bool anyPermissionSelected() {
    return selectedDays.isNotEmpty;
  }

  // Get all promo in branch record
  Future<void> fetchSpesificPromofromBranchRecord() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final promo = await promoRepository.getAllPromoRecord();
      // asign branch
      allPromo.assignAll(promo.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());
      allPromoToView.assignAll(promo.where((element) {
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
          title: "Error get data promo", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // add data to selected days list
  void addDay(int index) {
    if (selectedDays.contains(index) == true) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }
  }

  // save promo in firestore
  Future<void> savePromo() async {
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
      if (!promoGeneral.currentState!.validate()) {
        isLoadingAdd.value = false;
        return;
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newPromo = PromoModel(
        branchID: selectedBranchID.value.isEmpty
            ? branchIDActive
            : selectedBranchID.value,
        promoID: selectedPromoID.value.isEmpty
            ? "prm-$genericID"
            : selectedPromoID.value,
        promoType: selectedPromoType.value,
        promoName: promoNameController.text.trim(),
        promoDescription: promoDescriptionController.text.trim(),
        discountType: selectedDiscountType.value,
        discountPercent: selectedDiscountType.value == "percent"
            ? double.parse(discountPercentController.text.trim())
            : 0,
        discountAmount: selectedDiscountType.value == "amount"
            ? double.parse(discountAmountController.text.trim())
            : 0,
        maximumDiscount: maximumDiscountController.text.isEmpty
            ? 0
            : double.parse(maximumDiscountController.text.trim()),
        minimumPurchase: minimumPurchaseController.text.isEmpty
            ? 0
            : double.parse(minimumPurchaseController.text.trim()),
        promotionActiveType: promotionActiveType.value,
        startDate: startDateController.text.trim(),
        endDate: endDateController.text.trim(),
        activeDays: selectedDays,
        promotionHour: selectedPromotionHour.value,
        startHour: startHourController.text.trim(),
        endHour: endHourController.text.trim(),
        categoryPromotions: selectedCategoryForPromo
            .map((category) => category.toJson())
            .toList(),
        menuPromotions:
            selectedMenuForPromo.map((category) => category.toJson()).toList(),
        qtyMultiplePurchase: multiplePurchasesQty.text.isNotEmpty
            ? int.parse(multiplePurchasesQty.text)
            : 0,
      );
      // Save promo data in the firebase database
      await promoRepository.savePromo(newPromo);

      await fetchSpesificPromofromBranchRecord();

      promoNameController.clear();
      promoDescriptionController.clear();
      maximumDiscountController.clear();
      discountPercentController.clear();
      discountAmountController.clear();
      minimumPurchaseController.clear();
      startDateController.clear();
      endDateController.clear();
      startHourController.clear();
      endHourController.clear();
      selectedDiscountType.value = "amount";
      selectedPromoType.value = "general";
      promotionActiveType.value = "always";
      selectedDays.clear();
      selectedPromotionHour.value = false;
      selectedCategoryForPromo.clear();
      selectedMenuForPromo.clear();
      multiplePurchasesQty.clear();
      backupDataCategory.clear();
      backupDataMenu.clear();
      allCategoryInNotselectedCategoryForPromo.clear();
      allMenuInNotselectedMenuForPromo.clear();

      // back to promo screen
      Get.back(id: 3);

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Promo added", message: "Promo success added");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error add promo", message: "Please try again later");
    }
  }

  // delete promo
  Future<void> deletePromoRecord(String promoID) async {
    try {
      // show loading
      isLoadingDelete.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingDelete.value = false;
        return;
      }

      // delete category data in the firebase database
      await promoRepository.deletePromoRecord(promoID);

      // back to promo screen
      Get.back();

      await fetchSpesificPromofromBranchRecord();

      // stop loading
      isLoadingDelete.value = false;
    } catch (e) {
      // stop loading
      isLoadingDelete.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error delete promo", message: "Please try again later");
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
      allMenuInNotselectedMenuForPromo.assignAll(menu.where((element) {
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

  // init data edit promo
  void initDataUpdate({
    required String branchID,
    required String promoID,
    required String promoType,
    required String discountType,
    required String promoName,
    required String promoDescription,
    required double maximumDiscount,
    required double discountPercent,
    required double discountAmount,
    required double minimumPurchase,
    required String dataPromotionActiveType,
    required String startDate,
    required String endDate,
    required List dataActiveDays,
    required bool promotionHour,
    required String startHour,
    required String endHour,
    required List menuPromotions,
    required List categoryPromotions,
    required int qtyMultiplePurchase,
  }) {
    selectedBranchID.value = branchID;
    selectedPromoID.value = promoID;
    selectedPromoType.value = promoType;
    promoNameController.text = promoName;
    selectedDiscountType.value = discountType;
    promoDescriptionController.text = promoDescription;
    maximumDiscountController.text = maximumDiscount.toString();
    discountPercentController.text = discountPercent.toString();
    discountAmountController.text = discountAmount.toString();
    minimumPurchaseController.text = minimumPurchase.toString();
    promotionActiveType.value = dataPromotionActiveType;
    startDateController.text = startDate;
    endDateController.text = endDate;
    selectedDays.assignAll(dataActiveDays);
    selectedPromotionHour.value = promotionHour;
    startHourController.text = startHour;
    endHourController.text = endHour;
    selectedMenuForPromo
        .assignAll(convertDynamicListToMenuModelList(menuPromotions));
    selectedCategoryForPromo
        .assignAll(convertDynamicListToCategoryModelList(categoryPromotions));
    multiplePurchasesQty.text = qtyMultiplePurchase.toString();
  }

  // Function to convert list of dynamic objects to list of MenuModel objects
  List<MenuModel> convertDynamicListToMenuModelList(List<dynamic> dynamicList) {
    List<MenuModel> menuModelList = [];

    for (var dynamicItem in dynamicList) {
      // Convert each dynamic item into MenuModel and add it to the menuModelList
      MenuModel menuModel = MenuModel(
        menuID: dynamicItem["menuID"],
        merchantID: dynamicItem["merchantID"],
        branchID: dynamicItem["branchID"],
        menuName: dynamicItem["menuName"],
        menuImage: dynamicItem["menuImage"],
        description: dynamicItem["description"],
        category: dynamicItem["category"],
        allowFlexiblePrice: dynamicItem["allowFlexiblePrice"],
        price: dynamicItem["price"],
        recipes: dynamicItem["recipes"],
        addons: dynamicItem["addons"],
      );
      menuModelList.add(menuModel);
    }

    return menuModelList;
  }

  // Function to convert list of dynamic objects to list of CategoryModel objects
  List<CategoryModel> convertDynamicListToCategoryModelList(
      List<dynamic> dynamicList) {
    List<CategoryModel> categoryModelList = [];

    for (var dynamicItem in dynamicList) {
      // Convert each dynamic item into CategoryModel and add it to the menuModelList
      CategoryModel categoryModel = CategoryModel(
          categoryID: dynamicItem["categoryID"],
          merchantID: dynamicItem["merchantID"],
          branchID: dynamicItem["branchID"],
          categoryName: dynamicItem["categoryName"]);
      categoryModelList.add(categoryModel);
    }

    return categoryModelList;
  }

  // fetch all category in spesific branch
  Future<void> fetchSpesificCategoryfromBranchRecord() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final category = await categoryRepository.getAllCategoryRecord();
      // asign category
      allCategory.assignAll(category.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());
      allCategoryInNotselectedCategoryForPromo
          .assignAll(category.where((element) {
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
          title: "Error get data category", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // add menu to list
  void addToSelectedMenu(
    String menuID,
    String merchantID,
    String branchID,
    String menuName,
    String menuImage,
    String description,
    String category,
    bool allowFlexiblePrice,
    double price,
    List recipes,
    List addons,
  ) {
    int index = allMenuInNotselectedMenuForPromo
        .indexWhere((menu) => menu.menuID == menuID);
    if (index != -1) {
      // Hapus menu dari allMenuInNotselectedMenuForPromo jika ditemukan
      allMenuInNotselectedMenuForPromo.removeAt(index);

      // Tambahkan menu ke selectedMenuForPromo
      MenuModel data = MenuModel(
          menuID: menuID,
          merchantID: merchantID,
          branchID: branchID,
          menuName: menuName,
          menuImage: menuImage,
          description: description,
          category: category,
          allowFlexiblePrice: allowFlexiblePrice,
          price: price,
          recipes: recipes,
          addons: addons);
      selectedMenuForPromo.add(data);
    }
    backupDataMenu.assignAll(allMenuInNotselectedMenuForPromo);
    // close dialog
    Get.back();
  }

  // add category to list
  void addToSelectedCategory(
    String categoryID,
    String merchantID,
    String branchID,
    String categoryName,
  ) {
    int index = allCategoryInNotselectedCategoryForPromo
        .indexWhere((category) => category.categoryID == categoryID);
    if (index != -1) {
      // Hapus category dari allCategoryInNotselectedMenuForPromo jika ditemukan
      allCategoryInNotselectedCategoryForPromo.removeAt(index);

      // Tambahkan category ke selectedCategoryForPromo
      CategoryModel data = CategoryModel(
        categoryID: categoryID,
        merchantID: merchantID,
        branchID: branchID,
        categoryName: categoryName,
      );
      selectedCategoryForPromo.add(data);
    }
    backupDataCategory.assignAll(allCategoryInNotselectedCategoryForPromo);
    // close dialog
    Get.back();
  }

  // remove menu in selected list
  void deleteSelectedMenu(int index) {
    // Ambil menu yang akan dihapus dari selectedMenuForPromo
    MenuModel deletedMenu = selectedMenuForPromo[index];

    // Hapus menu dari selectedMenuForPromo
    selectedMenuForPromo.removeAt(index);

    // Temukan posisi tempat menu harus disisipkan kembali ke allMenuInNotselectedMenuForPromo
    int insertIndex = 0;
    for (;
        insertIndex < allMenuInNotselectedMenuForPromo.length;
        insertIndex++) {
      if (allMenuInNotselectedMenuForPromo[insertIndex]
              .menuID
              .compareTo(deletedMenu.menuID) >
          0) {
        break;
      }
    }

    // Sisipkan menu kembali ke allMenuInNotselectedMenuForPromo sesuai dengan urutan aslinya
    allMenuInNotselectedMenuForPromo.insert(insertIndex, deletedMenu);

    backupDataMenu.assignAll(allMenuInNotselectedMenuForPromo);
  }

  // remove category in selected list
  void deleteSelectedCategory(int index) {
    // Ambil category yang akan dihapus dari selectedcategoryForPromo
    CategoryModel deletedCategory = selectedCategoryForPromo[index];

    // Hapus category dari selectedcategoryForPromo
    selectedCategoryForPromo.removeAt(index);

    // Temukan posisi tempat category harus disisipkan kembali ke allcategoryInNotselectedcategoryForPromo
    int insertIndex = 0;
    for (;
        insertIndex < allCategoryInNotselectedCategoryForPromo.length;
        insertIndex++) {
      if (allCategoryInNotselectedCategoryForPromo[insertIndex]
              .categoryID
              .compareTo(deletedCategory.categoryID) >
          0) {
        break;
      }
    }

    // Sisipkan category kembali ke alcategoryInNotselectedcategoryForPromo sesuai dengan urutan aslinya
    allCategoryInNotselectedCategoryForPromo.insert(
        insertIndex, deletedCategory);

    backupDataCategory.assignAll(allCategoryInNotselectedCategoryForPromo);
  }

  // search menu
  void filterNameDataMenu() {
    List<MenuModel> filterData({
      required List<MenuModel> data,
      required String namaSearchField,
    }) {
      return data
          .where((element) =>
              element.menuName
                  .trim()
                  .toLowerCase()
                  .contains(namaSearchField.trim().toLowerCase()) &&
              !selectedMenuForPromo
                  .any((selectedItem) => selectedItem.menuID == element.menuID))
          .toList(growable: false);
    }

    if (searchMenu.value.text.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<MenuModel> updateData =
          filterData(data: allMenu, namaSearchField: searchMenu.value.text);
      allMenuInNotselectedMenuForPromo.assignAll(updateData);
    } else {
      allMenuInNotselectedMenuForPromo.assignAll(backupDataMenu);
    }
  }

  // search category
  void filterNameDataCategory() {
    List<CategoryModel> filterData({
      required List<CategoryModel> data,
      required String namaSearchField,
    }) {
      return data
          .where((element) =>
              element.categoryName
                  .trim()
                  .toLowerCase()
                  .contains(namaSearchField.trim().toLowerCase()) &&
              !selectedCategoryForPromo.any((selectedItem) =>
                  selectedItem.categoryID == element.categoryID))
          .toList(growable: false);
    }

    if (searchCategory.value.text.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<CategoryModel> updateData = filterData(
          data: allCategory, namaSearchField: searchCategory.value.text);
      allCategoryInNotselectedCategoryForPromo.assignAll(updateData);
    } else {
      allCategoryInNotselectedCategoryForPromo.assignAll(backupDataCategory);
    }
  }
}
