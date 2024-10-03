import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddressFromMapController extends GetxController {
  static AddressFromMapController get instance => Get.find();

  // variable
  final addressFromMap = TextEditingController().obs;

  RxString address = "".obs;
}
