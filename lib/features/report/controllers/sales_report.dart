import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/order/order_repository.dart';
import 'package:restaurant_bukuku/features/order/models/order_model.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class SalesReportController extends GetxController {
  static SalesReportController get instance => Get.find();

  // variable
  RxBool isLoadingGet = false.obs;
  RxList<OrderModel> orderInitData = <OrderModel>[].obs;
  RxList<OrderModel> orderFilteredData = <OrderModel>[].obs;

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

      // asign order
      orderInitData.assignAll(order);
      orderFilteredData.assignAll(order);
    } catch (e) {
      // stop loading
      isLoadingGet.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data report", message: "Please try again later");
    } finally {
      // stop loading
      isLoadingGet.value = false;
    }
  }
}
