import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/table/group_table.dart';
import 'package:restaurant_bukuku/data/repositories/table/layout_table.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/table/models/group_table_model.dart';
import 'package:restaurant_bukuku/features/table/models/table_model.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_1.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_11.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_12.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_13.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_14.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_15.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_16.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_2.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_3.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_4.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_5.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_6.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_7.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_8.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class TableController extends GetxController {
  static TableController get instance => Get.find();

  final tableGroupRepository = Get.put(GroupTableRepository());
  final tableLayoutRepository = Get.put(LayoutTableRepository());
  final createOrderController = Get.put(CreateOrderController());
  GetStorage localStorage = GetStorage();

  // variable
  GlobalKey<FormState> tableGroupFormKey = GlobalKey();
  RxInt capacity = 1.obs;
  RxBool editLayout = false.obs;
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool active = false.obs;
  final RxString selectedGroupID = "".obs;
  final RxString selectedBranchID = "".obs;

  final searchGroupTable = TextEditingController();
  final groupTableNameController = TextEditingController();
  final tableName = TextEditingController();

  RxList<String> dataColumnLabel =
      <String>["No", "Group Name", "Status", "action".tr].obs;
  RxList<GroupTableModel> allGroupTable = <GroupTableModel>[].obs;
  RxList<GroupTableModel> allGroupTableForView = <GroupTableModel>[].obs;

  RxString selectedComponent = "component1".obs;
  List<String> dataComponent = [
    "component1",
    "component2",
    "component3",
    "component4",
    "component5",
    "component6",
    "component7",
    "component8",
    "component11",
    "component12",
    "component13",
    "component14",
    "component15",
    "component16",
  ];
  RxList<TableModelLayout> allLayoutTableForView = <TableModelLayout>[].obs;
  RxList<TableModelLayout> allLayoutTableForInit = <TableModelLayout>[].obs;
  List<String> deleteTableOrObject = <String>[];

  late Offset startingFocalPoint;
  late Offset previousOffset;
  Offset offset = Offset.zero;
  late double previousZoom;
  double zoom = 1.0;

  @override
  void onInit() {
    fetchSpesificTableGroupfromBranchRecord();
    fetchSpesificTableLayoutfromBranchRecord();
    super.onInit();
  }

  void resetValues() {
    startingFocalPoint = Offset.zero;
    previousOffset = Offset.zero;
    offset = Offset.zero;
    previousZoom = 1.0;
    zoom = 1.0;
  }

  void handleScaleStart(ScaleStartDetails details) {
    final tableController = Get.put(TableController());

    startingFocalPoint = details.focalPoint;
    previousOffset = offset;
    previousZoom = zoom;
    tableController.refresh();
  }

  void handleScaleUpdate(ScaleUpdateDetails details, int index) {
    final tableController = Get.put(TableController());

    zoom = previousZoom * details.scale;

    // Ensure that item under the focal point stays in the same place despite zooming
    final Offset normalizedOffset =
        (startingFocalPoint - previousOffset) / previousZoom;
    offset = details.focalPoint - normalizedOffset * zoom;

    // Update table offsets in dummyTables
    allLayoutTableForView[index].offsetDx = offset.dx;
    allLayoutTableForView[index].offsetDy = offset.dy;

    tableController.refresh();
  }

  // cancel edit layout
  void cancelUpdateLayout() {
    editLayout.value = !editLayout.value;
    deleteTableOrObject.clear();
    fetchSpesificTableLayoutfromBranchRecord();
  }

  // remove object
  void removeObject(int index, String tableID) {
    final tableController = Get.put(TableController());
    allLayoutTableForView.removeAt(index);
    deleteTableOrObject.add(tableID);
    tableController.refresh();
  }

  // add group table selected to textcontroller fungction
  void selectedGroupTable(String groupID, String groupName) {
    selectedGroupID.value = groupID;

    groupTableNameController.text = groupName;

    allLayoutTableForView.assignAll(allLayoutTableForInit.where((element) {
      return element.groupID
          .toString()
          .trim()
          .toLowerCase()
          .contains(selectedGroupID.value.toString().trim().toLowerCase());
    }).toList());

    allLayoutTableForView.refresh();
    TableController.instance.refresh();

    Get.back();
  }

  // add object table
  Future<void> addObjectTable() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    final tableController = Get.put(TableController());

    // create generic id from datetime epoch
    final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

    TableModelLayout data = TableModelLayout(
        branchID: branchIDActive,
        groupID: selectedGroupID.value,
        groupName: groupTableNameController.text.trim(),
        tableID: "tbl-$genericID",
        tableName: tableName.text.trim(),
        componentID: selectedComponent.value,
        offsetDx: 0.0,
        offsetDy: 0.0,
        maxQty: capacity.value,
        status: true,
        rotate: false);

    allLayoutTableForView.add(data);

    tableName.clear();
    capacity.value = 1;
    selectedComponent.value = "component1";

    tableController.refresh();

    Get.back();
  }

  // add object other table
  Future<void> addObject() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    final tableController = Get.put(TableController());

    // create generic id from datetime epoch
    final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

    TableModelLayout data = TableModelLayout(
        branchID: branchIDActive,
        groupID: selectedGroupID.value,
        groupName: groupTableNameController.text.trim(),
        tableID: "tbl-$genericID",
        tableName: tableName.text.trim(),
        componentID: selectedComponent.value,
        offsetDx: 0.0,
        offsetDy: 0.0,
        maxQty: 1,
        status: true,
        rotate: false);

    allLayoutTableForView.add(data);

    tableName.clear();
    capacity.value = 1;
    selectedComponent.value = "component1";

    tableController.refresh();
    createOrderController.fetchSpecificTableFromBranchRecord();
    createOrderController.fetchSpecificTableGroupFromBranchRecord();

    Get.back();
  }

  // get all spresifik table layout in branch active
  Future<void> fetchSpesificTableGroupfromBranchRecord() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final tableGroup = await tableGroupRepository.getAllGroupTableRecord();
      // asign branch
      allGroupTable.assignAll(tableGroup.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());
      allGroupTableForView.assignAll(tableGroup.where((element) {
        return element.branchID
            .toString()
            .trim()
            .toLowerCase()
            .contains(branchIDActive.toString().trim().toLowerCase());
      }).toList());

      selectedGroupID.value = allGroupTableForView[0].groupID;

      groupTableNameController.text = allGroupTableForView[0].groupName;
      ;
    } catch (e) {
      // stop loading
      isLoadingGet.value = false;
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // get all spresifik table group in branch active
  Future<void> fetchSpesificTableLayoutfromBranchRecord() async {
    String branchIDActive = await localStorage.read('branchIDActive');
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final table = await tableLayoutRepository.getAllLayoutTableRecord();
      // asign branch
      allLayoutTableForView.assignAll(table.where((element) {
        return element.branchID
                .toString()
                .trim()
                .toLowerCase()
                .contains(branchIDActive.toString().trim().toLowerCase()) &&
            element.groupID.toString().trim().toLowerCase().contains(
                selectedGroupID.value.toString().trim().toLowerCase());
      }).toList());
      allLayoutTableForInit.assignAll(table.where((element) {
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
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  // save group table in firebase
  Future<void> saveGroupTableRecord() async {
    String branchIDActive = await localStorage.read('branchIDActive');
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
      if (!tableGroupFormKey.currentState!.validate()) {
        isLoadingAdd.value = false;
        return;
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newGroup = GroupTableModel(
        branchID: branchIDActive,
        groupID: "gtb-$genericID",
        groupName: groupTableNameController.value.text.trim(),
        status: active.value,
      );
      // Save group table data in the firebase database
      await tableGroupRepository.saveGroupTable(newGroup);

      active.value = false;
      groupTableNameController.clear();

      createOrderController.fetchSpecificTableFromBranchRecord();
      createOrderController.fetchSpecificTableGroupFromBranchRecord();
      createOrderController.refresh();

      // close dialog
      Get.back();

      await fetchSpesificTableGroupfromBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Table group added", message: "Table group success added");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save table group", message: "Please try again later");
    }
  }

  // save layout edit
  Future<void> saveLayoutTable() async {
    try {
      // show loading
      isLoadingAdd.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingAdd.value = false;
        return;
      }

      if (deleteTableOrObject.isNotEmpty) {
        await tableLayoutRepository
            .deletSpesifikLayoutTableRecord(deleteTableOrObject);
      }

      for (var data in allLayoutTableForView) {
        // put data in model
        final newLayout = TableModelLayout(
            branchID: data.branchID,
            groupID: data.groupID,
            groupName: data.groupName,
            tableID: data.tableID,
            tableName: data.tableName,
            componentID: data.componentID,
            offsetDx: data.offsetDx,
            offsetDy: data.offsetDy,
            maxQty: data.maxQty,
            status: data.status,
            rotate: data.rotate);

        // Save group table data in the firebase database
        await tableLayoutRepository.saveLayoutTableRecord(newLayout);
      }

      resetValues();

      editLayout.value = false;
      deleteTableOrObject.clear();

      createOrderController.fetchSpecificTableFromBranchRecord();
      createOrderController.fetchSpecificTableGroupFromBranchRecord();
      createOrderController.refresh();

      await fetchSpesificTableLayoutfromBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Table layout update", message: "Table layout success update");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save table layout", message: "Please try again later");
    }
  }

  // update group table in firebase
  Future<void> updateGroupTableRecord() async {
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
      if (!tableGroupFormKey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }

      // put data in model
      final updateGroup = GroupTableModel(
        branchID: selectedBranchID.value,
        groupID: selectedGroupID.value,
        groupName: groupTableNameController.value.text.trim(),
        status: active.value,
      );
      // Save group table data in the firebase database
      await tableGroupRepository.updateGroupTable(updateGroup);

      active.value = false;
      groupTableNameController.clear();

      // close dialog
      Get.back();

      createOrderController.fetchSpecificTableFromBranchRecord();
      createOrderController.fetchSpecificTableGroupFromBranchRecord();
      await fetchSpesificTableGroupfromBranchRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Table group updated", message: "Table group success updated");

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error updated table group",
          message: "Please try again later");
    }
  }

  // save status group table in firebase
  Future<void> updateStatusGroupTableRecord(
      String groupTableID, bool status) async {
    try {
      // show loading
      isLoadingUpdate.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingUpdate.value = false;
        return;
      }

      // Save status group table data in the firebase database
      await tableGroupRepository.updateStatusGroupTable(groupTableID, status);

      createOrderController.fetchSpecificTableFromBranchRecord();
      createOrderController.fetchSpecificTableGroupFromBranchRecord();
      await fetchSpesificTableGroupfromBranchRecord();

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save status table group",
          message: "Please try again later");
    }
  }

  // delete group table in firebase
  Future<void> deleteGroupTableRecord(String groupTableID) async {
    try {
      // show loading
      isLoadingUpdate.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingUpdate.value = false;
        return;
      }

      // delete group table data in the firebase database
      await tableGroupRepository.deleteGroupTableRecord(groupTableID);

      createOrderController.fetchSpecificTableFromBranchRecord();
      createOrderController.fetchSpecificTableGroupFromBranchRecord();
      await fetchSpesificTableGroupfromBranchRecord();

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error delete table group", message: "Please try again later");
    }
  }

  // return widget condition component
  Widget component(String componentID, String tableName, int maxQty) {
    if (componentID == "component1") {
      return Component1(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component2") {
      return Component2(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component3") {
      return Component3(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component4") {
      return Component4(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component5") {
      return Component5(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component6") {
      return Component6(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component7") {
      return Component7(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component8") {
      return Component8(
        tableName: tableName,
        tableQty: maxQty,
      );
    } else if (componentID == "component11") {
      return Component11(
        tableName: tableName,
      );
    } else if (componentID == "component12") {
      return Component12(
        tableName: tableName,
      );
    } else if (componentID == "component13") {
      return Component13(
        tableName: tableName,
      );
    } else if (componentID == "component14") {
      return Component14(
        tableName: tableName,
      );
    } else if (componentID == "component15") {
      return Component15(
        tableName: tableName,
      );
    } else if (componentID == "component16") {
      return Component16(
        tableName: tableName,
      );
    } else {
      return const SizedBox();
    }
  }

  // orderirng branch data by search
  void orderBySearch() async {
    List<GroupTableModel> filterData({
      required List<GroupTableModel> data,
      required String namaSearchField,
    }) {
      return data
          .where((element) => element.groupName
              .trim()
              .toLowerCase()
              .contains(namaSearchField.trim().toLowerCase()))
          .toList(growable: false);
    }

    if (searchGroupTable.value.text.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<GroupTableModel> updateData = filterData(
          data: allGroupTable, namaSearchField: searchGroupTable.value.text);
      allGroupTableForView.assignAll(updateData);
    } else {
      allGroupTableForView.assignAll(allGroupTable);
    }
  }

  // init data update
  void initDataUpdate({
    required String branchID,
    required String tableGroupID,
    required String tableGroupName,
    required bool status,
  }) {
    selectedBranchID.value = branchID;
    selectedGroupID.value = tableGroupID;
    groupTableNameController.text = tableGroupName;
    active.value = status;
  }
}
