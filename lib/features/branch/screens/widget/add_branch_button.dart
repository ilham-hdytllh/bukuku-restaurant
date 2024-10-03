import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/branch/screens/add_branch_screen.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class AddBranchButton extends StatelessWidget {
  const AddBranchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TSizes.inputFieldHeight,
      child: ElevatedButton.icon(
        onPressed: () => Get.to(
          const AddBranchScreen(),
          id: 6,
          duration: Duration.zero,
          transition: Transition.noTransition,
        ),
        icon: const Icon(
          Iconsax.add_copy,
          size: 18,
          color: TColors.white,
        ),
        label: Text("branch".tr),
      ),
    );
  }
}
