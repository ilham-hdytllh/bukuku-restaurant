import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/menu_add_screen.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class NavigateButtonAddMenuScreen extends StatelessWidget {
  const NavigateButtonAddMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TSizes.inputFieldHeight,
      width: 130,
      child: ElevatedButton.icon(
        onPressed: () => Get.to(const AddMenuScreen(),
            id: 2,
            duration: const Duration(milliseconds: 500),
            transition: Transition.fade),
        icon: const Icon(
          Iconsax.add,
          size: TSizes.iconSm,
          color: TColors.white,
        ),
        label: const Text("Menu"),
      ),
    );
  }
}
