import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/data/repositories/branch/branch_repository.dart';
import 'package:restaurant_bukuku/data/repositories/employe/employe_repository.dart';
import 'package:restaurant_bukuku/data/repositories/firebase_storage/image/firebase_storage_image_repository.dart';
import 'package:restaurant_bukuku/data/repositories/menu/menu_repository.dart';
import 'package:restaurant_bukuku/data/repositories/merchant/merchant_repository.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/pin/create_pin_controllers.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/signup/signup_controller.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/features/branch/models/branch_model.dart';

import 'package:restaurant_bukuku/features/employe/models/employe/employe_model.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/menu_model.dart';
import 'package:restaurant_bukuku/features/navigation/screens/main_navigation/main_navigation.dart';
import 'package:restaurant_bukuku/features/system/controller/address_from_map/address_from_map.dart';
import 'package:restaurant_bukuku/utils/popups/loader.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // variable
  RxBool isLoading = false.obs;

  // send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // send email verification link
  sendEmailVerification() async {
    try {
      // call repository authentication to acces function send email verify
      await AuthenticationRepository.instance.sendEmailVerification();
      // show snackbar eror if success
      CustomSnackbar.successSnackbar(
          title: "Email Sent",
          message: 'Please check yut inbox and verify your email.');
    } catch (e) {
      // show snackbar eror if eror
      CustomSnackbar.errorSnackbar(title: "Oh Snap", message: e.toString());
    }
  }

  // timer to automaticly redirect on email verifivation
  setTimerForAutoRedirect() {
    // declare getstorage
    final localStorage = GetStorage();
    // call controller signup controller
    final signupController = Get.put(SignupController());
    // call controller starting setup controller to get all input in starter setup
    final startingSetupController = Get.put(StartingSetupController());
    // call controller starting setup controller to get all input in starter setup
    final addressFromMapController = Get.put(AddressFromMapController());
    // call controller Image ffirabse storage repository
    final firebaseStorageImageRepository =
        Get.put(ImageFirebaseStorageRepository());
    // call pin controller
    final createPinController = Get.put(PinController());
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      // cek condition email verify or no
      if (user?.emailVerified ?? false) {
        timer.cancel();

        // set value loading true
        isLoading.value = true;
        // open the loading dialog
        TFullScreenLoader.openLoadingDialog();

        // variable url image restaurant logo
        String urlRestaurantLogo = "";

        // cek the image is null or not , if not continue to upload firebase storage
        if (startingSetupController.mobileImageForUpload.value != null) {
          urlRestaurantLogo = await firebaseStorageImageRepository.uploadImage(
              "Logos/", startingSetupController.mobileImageForUpload.value!);
        }

        // variable url image menu
        String urlMenu = "";

        // cek the image is null or not , if not continue to upload firebase storage
        if (startingSetupController.mobileImageMenuForUpload.value != null) {
          urlMenu = await firebaseStorageImageRepository.uploadImage("Menus/",
              startingSetupController.mobileImageMenuForUpload.value!);
        }

        // declaration data to update in merchant document
        final Map<String, dynamic> data = {
          "restaurantAddress":
              addressFromMapController.addressFromMap.value.text.trim(),
          "restaurantCurrency":
              startingSetupController.restaurantCurrency.text.trim(),
          "restaurantLogo": urlRestaurantLogo,
          "restaurantName": startingSetupController.restaurantName.text.trim(),
          "restaurantType": startingSetupController.restaurantType,
        };

        // call controler merchant repository
        final merchantRepository = Get.put(MerchantRepository());
        // update merchant data
        await merchantRepository.updateMerchantRecord(data);
        // create generic id from datetime epoch
        final String genericID =
            DateTime.now().millisecondsSinceEpoch.toString();

        // put into model branch
        final branch = BranchModel(
          merchantID: user!.uid,
          branchID: "bch-$genericID",
          branchAddress:
              addressFromMapController.addressFromMap.value.text.trim(),
          branchName: "Cabang 1",
          branchDialCode: "",
          branchPhoneNo: "",
          branchEmail: user.email!,
        );
        // call controller branch repository
        final branchRepository = Get.put(BranchRepository());
        // update branch data
        await branchRepository.saveBranch(branch);
        // save in local storage branch name
        localStorage.write('branchNameActive', branch.branchName);
        localStorage.write('branchIDActive', branch.branchID);

        // put into model branch
        final employe = EmployeModel(
          merchantID: user.uid,
          branchID: branch.branchID,
          employeEmail: user.email!,
          employeID: "emp-$genericID",
          employeName: signupController.usernameBackup.value,
          pin: createPinController.confirmPIN.value,
          role: "master",
        );
        // call controller employe repository
        final employeRepository = Get.put(EmployeRepository());
        // update merchant data
        await employeRepository.saveEmploye(employe);
        // save in local storage employe id and employe name
        localStorage.write(
            'employeNameActive', signupController.usernameBackup.value);
        localStorage.write('employeIDActive', "emp-$genericID");
        localStorage.write('employeRoleIDActive', "master");

        // put into menu model
        final menu = MenuModel(
          menuID: "mnu-$genericID",
          merchantID: user.uid,
          branchID: branch.branchID,
          menuName: startingSetupController.menuName.text,
          menuImage: urlMenu,
          category: "",
          description: "",
          allowFlexiblePrice: false,
          addons: [],
          recipes: [],
          price: double.parse(startingSetupController.menuPrice.text),
        );

        final menuRepository = Get.put(MenuRepository());
        // update merchant data
        await menuRepository.saveMenu(menu);

        // Method to save lastValidationPIN time (if the session 1 day so user must input the pin again)
        await GetStorage()
            .write('lastValidationPIN', DateTime.now().millisecondsSinceEpoch);

        // set variable loading false
        isLoading.value = false;

        // stop loading dialog
        TFullScreenLoader.stopLoading();

        // navigate to main navigation and remove all controller
        Get.offAll(() => const MainNavigation());
      }
    });
  }

  // manually check if email verified
  checkEmailVerficationStatus() async {
    final curentUser = FirebaseAuth.instance.currentUser;
    // cek user is verified or no
    if (curentUser != null && curentUser.emailVerified) {
      // navigate to main navigation
      Get.off(() => const MainNavigation());
    }
  }
}
