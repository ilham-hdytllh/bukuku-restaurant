import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/features/authentication/screens/starting_setup/widget/setup_one_form.dart';
import 'package:restaurant_bukuku/features/authentication/screens/starting_setup/widget/setup_two_form.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class StartingSetup extends StatelessWidget {
  const StartingSetup({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(StartingSetupController());
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(TImages.backgroundAuth),
              opacity: 0.1,
              fit: BoxFit.cover),
        ),
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: controller.updatePage,
          scrollDirection: Axis.horizontal,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: TSizes.appBarHeight,
                  horizontal: THelperFunctions.screenWidth() < 900
                      ? THelperFunctions.screenWidth() * 0.3
                      : THelperFunctions.screenWidth() * 0.25),
              child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? TColors.black
                        : TColors.white, // Warna latar belakang
                    borderRadius: BorderRadius.circular(10), // Bentuk border
                    boxShadow: [
                      BoxShadow(
                        color: TColors.darkGrey.withOpacity(
                            0.5), // Warna bayangan dan tingkat kejernihan
                        spreadRadius: 5, // Penyebaran bayangan
                        blurRadius: 7, // Tingkat kabur bayangan
                        offset: const Offset(
                            0, 3), // Perpindahan bayangan dari objek
                      ),
                    ],
                  ),
                  child: const SetupFormOne()),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: TSizes.appBarHeight,
                  horizontal: THelperFunctions.screenWidth() < 900
                      ? THelperFunctions.screenWidth() * 0.3
                      : THelperFunctions.screenWidth() * 0.25),
              child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? TColors.black
                        : TColors.white, // Warna latar belakang
                    borderRadius: BorderRadius.circular(10), // Bentuk border
                    boxShadow: [
                      BoxShadow(
                        color: TColors.darkGrey.withOpacity(
                            0.5), // Warna bayangan dan tingkat kejernihan
                        spreadRadius: 5, // Penyebaran bayangan
                        blurRadius: 7, // Tingkat kabur bayangan
                        offset: const Offset(
                            0, 3), // Perpindahan bayangan dari objek
                      ),
                    ],
                  ),
                  child: const SetupFormTwo()),
            ),
          ],
        ),
      ),
    );
  }
}
