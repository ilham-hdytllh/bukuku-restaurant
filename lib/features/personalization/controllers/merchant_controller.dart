import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/merchant/merchant_repository.dart';
import 'package:restaurant_bukuku/features/authentication/models/merchant_model.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class MerchantController extends GetxController {
  static MerchantController get instance => Get.find();

  final merchantRepository = Get.put(MerchantRepository());

  // save user record from any registration provider
  Future<void> saveMerchant(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final merchant = MerchantModel(
          merchantID: userCredential.user!.uid,
          username: userCredential.user!.displayName ?? "",
          email: userCredential.user!.email ?? "",
          phoneNumber: userCredential.user!.phoneNumber ?? "",
          restaurantAddress: "",
          restaurantCurrency: "",
          restaurantLogo: "",
          restaurantName: "",
          restaurantType: [],
        );

        // save user data
        await merchantRepository.saveMerchantRecord(merchant);
      }
    } catch (e) {
      CustomSnackbar.warningSnackbar(
          title: "Data not saved",
          message:
              'Something when wrong while saving your information. You can re-save your data in your profile');
    }
  }
}
