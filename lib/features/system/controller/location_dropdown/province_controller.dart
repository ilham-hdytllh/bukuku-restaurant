import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/utils/utils.dart';

class ProvinceController extends GetxController {
  static ProvinceController get instance => Get.find();

  // Varibale
  RxList<dynamic> provinceData = [].obs;
  Rx<String> selectedProvinceId = "".obs;

  @override
  void onInit() async {
    Get.put(UtilsRepository());
    provinceData.assignAll(await UtilsRepository.instance.fetchProvinceData());
    super.onInit();
  }
}
