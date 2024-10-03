import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/utils/utils.dart';
import 'package:restaurant_bukuku/features/system/controller/location_dropdown/province_controller.dart';

class CityController extends GetxController {
  static CityController get instance => Get.find();

  final provinceController = Get.put(ProvinceController());

  // Varibale
  RxList<dynamic> cityData = [].obs;
  Rx<String> selectedCityId = "".obs;

  @override
  void onInit() async {
    super.onInit();
    // Panggil _fetchCityData() untuk pertama kali saat onInit dijalankan
    await _fetchCityData();
    // Gunakan ever untuk memantau perubahan selectedProvinceId setelah onInit pertama kali
    ever(provinceController.selectedProvinceId, (_) {
      _fetchCityData();
    });
  }

  Future<void> _fetchCityData() async {
    final utilsRepo = Get.find<UtilsRepository>();
    cityData.assignAll(await utilsRepo
        .fetchCityData(provinceController.selectedProvinceId.value));
  }
}
