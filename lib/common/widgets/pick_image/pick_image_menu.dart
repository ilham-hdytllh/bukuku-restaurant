import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class PickImageMenu extends StatelessWidget {
  final Function onTap1;
  final Function onTap2;

  const PickImageMenu({super.key, required this.onTap1, required this.onTap2});

  @override
  Widget build(BuildContext context) {
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
          onTap: () {
            onTap1();
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Iconsax.camera,
            size: TSizes.iconMd,
            color: TColors.primary,
          ),
          title: const Text("Ambil dari Camera"),
          onTap: () {
            onTap2();
          },
        ),
      ],
    );
  }
}
