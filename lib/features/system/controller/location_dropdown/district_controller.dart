import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/utils/utils.dart';
import 'package:restaurant_bukuku/features/system/controller/location_dropdown/city_controller.dart';

class DistrictController extends GetxController {
  static DistrictController get instance => Get.find();

  final cityController = Get.put(CityController());

  // Varibale
  RxList<dynamic> districtData = [].obs;
  Rx<String> selectedDistrictId = "".obs;

  @override
  void onInit() async {
    super.onInit();
    // Panggil _fetchDistrictData() untuk pertama kali saat onInit dijalankan
    await _fetchDistrictData();
    // Gunakan ever untuk memantau perubahan selectedCityId setelah onInit pertama kali
    ever(cityController.selectedCityId, (_) {
      _fetchDistrictData();
    });
  }

  Future<void> _fetchDistrictData() async {
    final utilsRepo = Get.find<UtilsRepository>();
    districtData.assignAll(
        await utilsRepo.fetchDistrictData(cityController.selectedCityId.value));
  }
}
