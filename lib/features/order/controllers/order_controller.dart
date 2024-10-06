import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/order/order_repository.dart';
import 'package:restaurant_bukuku/features/order/models/order_model.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // variable
  RxBool isLoadingGet = false.obs;
  RxString idOrder = "".obs;
  RxString filterSalesType = "All".obs;
  RxList<OrderModel> orderInitData = <OrderModel>[].obs;
  RxList<OrderModel> orderFilteredData = <OrderModel>[].obs;
  RxMap<String, dynamic> orderData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllOrderRecord();
  }

  // Get all order record
  Future<void> fetchAllOrderRecord() async {
    final orderRespository = Get.put(OrderRepository());
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final order = await orderRespository.getAllOrderRecord();

      idOrder.value = order[0].orderID;
      // asign order
      orderInitData.assignAll(order);
      orderFilteredData.assignAll(order);

      orderData.addAll({
        "orderID": order[0].orderID,
        "branchID": order[0].branchID,
        "cart": order[0].cart,
        "cashierName": order[0].cashierName,
        "customerName": order[0].customerName,
        "grossAmount": order[0].grossAmount,
        "merchantID": order[0].merchantID,
        "orderTime": order[0].orderTime,
        "pax": order[0].pax,
        "paymentStatus": order[0].paymentStatus,
        "salesType": order[0].salesType,
        "tableNumber": order[0].tableNumber,
      });
    } catch (e) {
      // stop loading
      isLoadingGet.value = false;
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }

  void setFilterData(String salesType) {
    filterSalesType.value = salesType;
    if (salesType == "All") {
      orderFilteredData.assignAll(orderInitData);

      if (orderFilteredData.isEmpty) {
        idOrder.value = "";
      } else {
        idOrder.value = orderFilteredData[0].orderID;
        orderData.addAll({
          "orderID": orderFilteredData[0].orderID,
          "branchID": orderFilteredData[0].branchID,
          "cart": orderFilteredData[0].cart,
          "cashierName": orderFilteredData[0].cashierName,
          "customerName": orderFilteredData[0].customerName,
          "grossAmount": orderFilteredData[0].grossAmount,
          "merchantID": orderFilteredData[0].merchantID,
          "orderTime": orderFilteredData[0].orderTime,
          "pax": orderFilteredData[0].pax,
          "paymentStatus": orderFilteredData[0].paymentStatus,
          "salesType": orderFilteredData[0].salesType,
          "tableNumber": orderFilteredData[0].tableNumber,
        });
      }
    } else {
      final data = orderInitData
          .where((element) => element.salesType == salesType)
          .toList();
      orderFilteredData.assignAll(data);

      if (orderFilteredData.isEmpty) {
        idOrder.value = "";
      } else {
        idOrder.value = orderFilteredData[0].orderID;
        orderData.addAll({
          "orderID": orderFilteredData[0].orderID,
          "branchID": orderFilteredData[0].branchID,
          "cart": orderFilteredData[0].cart,
          "cashierName": orderFilteredData[0].cashierName,
          "customerName": orderFilteredData[0].customerName,
          "grossAmount": orderFilteredData[0].grossAmount,
          "merchantID": orderFilteredData[0].merchantID,
          "orderTime": orderFilteredData[0].orderTime,
          "pax": orderFilteredData[0].pax,
          "paymentStatus": orderFilteredData[0].paymentStatus,
          "salesType": orderFilteredData[0].salesType,
          "tableNumber": orderFilteredData[0].tableNumber,
        });
      }
    }
  }

  void setOrderDetail(int index) {
    idOrder.value = orderFilteredData[index].orderID;
    orderData.addAll({
      "orderID": orderFilteredData[index].orderID,
      "branchID": orderFilteredData[index].branchID,
      "cart": orderFilteredData[index].cart,
      "cashierName": orderFilteredData[index].cashierName,
      "customerName": orderFilteredData[index].customerName,
      "grossAmount": orderFilteredData[index].grossAmount,
      "merchantID": orderFilteredData[index].merchantID,
      "orderTime": orderFilteredData[index].orderTime,
      "pax": orderFilteredData[index].pax,
      "paymentStatus": orderFilteredData[index].paymentStatus,
      "salesType": orderFilteredData[index].salesType,
      "tableNumber": orderFilteredData[index].tableNumber,
    });
  }
}
