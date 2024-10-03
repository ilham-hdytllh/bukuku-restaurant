import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class PickImageLogo extends StatelessWidget {
  const PickImageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StartingSetupController());
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Iconsax.picture_frame,
            size: TSizes.iconMd,
            color: TColors.primary,
          ),
          title: const Text("Ambil dari Galery"),
          onTap: () => controller.getRestaurantImageFromGallery(),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Iconsax.camera,
            size: TSizes.iconMd,
            color: TColors.primary,
          ),
          title: const Text("Ambil dari Camera"),
          onTap: () => controller.getRestaurantImageFromCamera(),
        ),
      ],
    );
  }
}
