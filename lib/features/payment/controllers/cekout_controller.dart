import 'package:get/get.dart';

class CekoutController extends GetxController {
  static CekoutController get instance => Get.find();

  // variable
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
}
