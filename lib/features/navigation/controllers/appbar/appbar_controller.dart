import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppBarController extends GetxController {
  static AppBarController get instance => Get.find();

  // Variable
  Rx<String> appBarTitle = "New Order".obs;
  RxString branchNameActive = "".obs;
  RxString branchIDActive = "".obs;
  RxString employeNameActive = "".obs;
  RxString employeIDActive = "".obs;

  @override
  void onInit() {
    super.onInit();
    setEmployeandBranchData();
  }

  void setEmployeandBranchData() {
    final localStorage = GetStorage();
    // set value from local to variable
    branchNameActive.value = localStorage.read('branchNameActive') ?? "";
    branchIDActive.value = localStorage.read('branchIDActive') ?? "";
    employeNameActive.value = localStorage.read('employeNameActive') ?? "";
    employeIDActive.value = localStorage.read('employeIDActive') ?? "";
  }
}
