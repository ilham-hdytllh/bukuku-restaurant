import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/data/repositories/menu/menu_repository.dart';
import 'package:restaurant_bukuku/data/repositories/order/order_repository.dart';
import 'package:restaurant_bukuku/data/repositories/table/group_table.dart';
import 'package:restaurant_bukuku/data/repositories/table/layout_table.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/cart_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/menu_model.dart';
import 'package:restaurant_bukuku/features/order/controllers/order_controller.dart';
import 'package:restaurant_bukuku/features/order/models/order_model.dart';
import 'package:restaurant_bukuku/features/report/controllers/sales_report.dart';
import 'package:restaurant_bukuku/features/table/models/group_table_model.dart';
import 'package:restaurant_bukuku/features/table/models/table_model.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateOrderController extends GetxController {
  static CreateOrderController get instance => Get.find();

  final localStorage = GetStorage();

  final isLoadingAdd = false.obs;
  final isLoadingUpdate = false.obs;
  final isLoadingGet = false.obs;
  final isLoadingDelete = false.obs;
  final wrapOrNo = true.obs;
  final quantityItem = 1.obs;
  final pax = 1.obs;
  final discountType = "rp".obs;
  final selectedCategoryFilter = "".obs;
  final selectedFilter = "all".obs;
  final selectedSalesType = "Dine In".obs;

  final searchMenuInPOS = TextEditingController();

  final tableAndGroupSelected = TextEditingController();
  final price = TextEditingController();
  final note = TextEditingController();
  final tableSelected = TextEditingController();
  final tableGroupSelected = TextEditingController();
  final customerName = TextEditingController();
  final selectedTableGroupID = "".obs;
  final selectedTableID = "".obs;
  final selectedPaymentMethod = "Tunai".obs;
  final allMenuInit = <MenuModel>[].obs;
  final allMenuToView = <MenuModel>[].obs;
  final cartItem = <MenuModel>[].obs;
  final allGroupTableInit = <GroupTableModel>[].obs;
  final allTableInit = <TableModelLayout>[].obs;
  final allTablebySelectedGroup = <TableModelLayout>[].obs;

  RxList salesType = [
    {
      "id": "1",
      "salesType": "Dine In",
      "description": "Akan dikenakan service charge setiap transaksi"
    },
    {
      "id": "2",
      "salesType": "Take Away",
      "description": "Tidak ada biaya tambahan"
    }
  ].obs;

  RxList paymentMethod = [
    {
      "id": "1",
      "payment": "Tunai",
      "image": "assets/images/no_animations/cash_image.png"
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpecificMenuFromBranchRecord();
    fetchSpecificTableGroupFromBranchRecord();
    fetchSpecificTableFromBranchRecord();
  }

  @override
  void onClose() {
    quantityItem.value = 1;
    super.onClose();
  }

  // save order
  Future<void> saveOrderToFirestore() async {
    final cartController = Get.put(CartController());
    final salesReportController = Get.put(SalesReportController());
    String branchIDActive = localStorage.read('branchIDActive') ?? "";
    String employeNameActive = localStorage.read('employeNameActive') ?? "";
    // String employeIDActive = localStorage.read('employeIDActive') ?? "";
    // String employeRoleIDActive = localStorage.read('employeRoleIDActive') ?? "";
    // String employeEmailActive = localStorage.read('employeEmailActive') ?? "";
    try {
      // show loading
      isLoadingAdd.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingUpdate.value = false;
        return;
      }

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('EEEE, dd MMM yyyy HH:mm').format(now);
      String id = DateTime.now().millisecondsSinceEpoch.toString();

      // Convert cartItem list to list of dynamic
      List<dynamic> cartItemListDynamic() {
        return cartController.cartItem
            .map((item) => {
                  'menuID': item.menuID,
                  'menuName': item.menuName,
                  'image': item.image,
                  'note': item.note,
                  'price': item.price,
                  'quantity': item.quantity,
                })
            .toList();
      }

      // put data in model
      final newOrder = OrderModel(
        merchantID: AuthenticationRepository.instance.authUser!.uid,
        branchID: branchIDActive,
        cart: cartItemListDynamic(),
        cashierName: employeNameActive,
        customerName: customerName.text.trim(),
        grossAmount: cartController.totalCartPrice.value,
        orderID: "order$id",
        orderTime: formattedDate,
        pax: pax.value,
        paymentStatus: "paid",
        salesType: selectedSalesType.value,
        tableNumber: tableSelected.text,
      );
      // call controller order repository
      final orderRepository = Get.put(OrderRepository());
      // Save order data in the firebase database
      await orderRepository.saveOrder(newOrder);

      salesReportController.fetchAllOrderRecord();

      cartController.cartItem.clear();
      customerName.clear();
      cartController.totalCartPrice.value = 0.0;
      pax.value = 1;
      selectedSalesType.value = "Dine In";
      tableSelected.clear();

      final orderController = Get.put(OrderController());
      orderController.fetchAllOrderRecord();

      // back to create order screen
      Get.back(id: 0);

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Order success", message: "Order success added");
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save order", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingAdd.value = false;
    }
  }

  Future<void> fetchSpecificMenuFromBranchRecord() async {
    final menuRepository = Get.put(MenuRepository());
    String branchIDActive = await localStorage.read('branchIDActive');

    try {
      isLoadingGet.value = true;
      final menu = await menuRepository.getAllMenuRecord();
      allMenuInit.assignAll(menu
          .where((element) => element.branchID
              .toString()
              .trim()
              .toLowerCase()
              .contains(branchIDActive.toString().trim().toLowerCase()))
          .toList());
      allMenuToView.assignAll(menu
          .where((element) => element.branchID
              .toString()
              .trim()
              .toLowerCase()
              .contains(branchIDActive.toString().trim().toLowerCase()))
          .toList());
    } catch (e) {
      isLoadingGet.value = false;
      CustomSnackbar.errorSnackbar(
          title: "Error get data menu", message: "Please try again later");
    } finally {
      isLoadingGet.value = false;
    }
  }

  Future<void> fetchSpecificTableGroupFromBranchRecord() async {
    final tableGroupRepository = Get.put(GroupTableRepository());
    String branchIDActive = await localStorage.read('branchIDActive');

    try {
      isLoadingGet.value = true;
      final group = await tableGroupRepository.getAllGroupTableRecord();
      allGroupTableInit.assignAll(group
          .where((element) => element.branchID
              .toString()
              .trim()
              .toLowerCase()
              .contains(branchIDActive.toString().trim().toLowerCase()))
          .toList());
    } catch (e) {
      isLoadingGet.value = false;
      CustomSnackbar.errorSnackbar(
          title: "Error get data group table",
          message: "Please try again later");
    } finally {
      isLoadingGet.value = false;
    }
  }

  void addAllTablebySelectedGroup() {
    allTablebySelectedGroup.assignAll(allTableInit
        .where((element) =>
            element.groupID.toString().trim().toLowerCase().contains(
                selectedTableGroupID.value.toString().trim().toLowerCase()) &&
            element.componentID.toString().trim().toLowerCase() !=
                "component11" &&
            element.componentID.toString().trim().toLowerCase() !=
                "component12" &&
            element.componentID.toString().trim().toLowerCase() !=
                "component13" &&
            element.componentID.toString().trim().toLowerCase() !=
                "component14" &&
            element.componentID.toString().trim().toLowerCase() !=
                "component15" &&
            element.componentID.toString().trim().toLowerCase() !=
                "component16" &&
            element.componentID.toString().trim().toLowerCase() !=
                "component17")
        .toList());
  }

  void selectedTable(String tableID, String tableName) {
    selectedTableID.value = tableID;
    tableSelected.text = tableName;
    Get.back();
  }

  void selectedGroupTable(String groupID, String groupName) {
    selectedTableGroupID.value = groupID;
    tableGroupSelected.text = groupName;
    addAllTablebySelectedGroup();
    Get.back();
  }

  void setGroupAndTable() {
    tableAndGroupSelected.text =
        "${tableGroupSelected.text},${tableSelected.text}";
    Get.back();
  }

  void setSalesType(String salesType) {
    selectedSalesType.value = salesType;
    Get.back();
  }

  Future<void> fetchSpecificTableFromBranchRecord() async {
    final tableRepository = Get.put(LayoutTableRepository());
    String branchIDActive = await localStorage.read('branchIDActive');

    try {
      isLoadingGet.value = true;
      final group = await tableRepository.getAllLayoutTableRecord();
      allTableInit.assignAll(group
          .where((element) => element.branchID
              .toString()
              .trim()
              .toLowerCase()
              .contains(branchIDActive.toString().trim().toLowerCase()))
          .toList());
    } catch (e) {
      isLoadingGet.value = false;
      CustomSnackbar.errorSnackbar(
          title: "Error get data group table",
          message: "Please try again later");
    } finally {
      isLoadingGet.value = false;
    }
  }

  void orderBySearch() async {
    List<MenuModel> filterData(
        {required List<MenuModel> data,
        required String namaSearchField,
        required String nameCategory}) {
      return data
          .where((element) =>
              element.menuName
                  .trim()
                  .toLowerCase()
                  .contains(searchMenuInPOS.value.text.trim().toLowerCase()) &&
              element.category
                  .trim()
                  .toLowerCase()
                  .contains(selectedCategoryFilter.value.trim().toLowerCase()))
          .toList();
    }

    if (searchMenuInPOS.value.text.isNotEmpty ||
        selectedCategoryFilter.value.isNotEmpty) {
      List<MenuModel> updateData = filterData(
          data: allMenuInit,
          namaSearchField: searchMenuInPOS.value.text,
          nameCategory: selectedCategoryFilter.value);
      allMenuToView.assignAll(updateData);
    } else {
      allMenuToView.assignAll(allMenuInit);
    }
  }

  Future<void> addToCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cartItem
        .map((item) =>
            '${item.menuName},${item.price},${quantityItem.value},${note.text}')
        .toList();
    prefs.setStringList('cartItems', cartData);
  }
}
