import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/customer/screens/customer_add_screen.dart';

import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class AddCustomerButton extends StatelessWidget {
  const AddCustomerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TSizes.inputFieldHeight,
      child: ElevatedButton.icon(
        onPressed: () => Get.to(const AddCustomerScreen(),
            id: 8,
            duration: const Duration(milliseconds: 500),
            transition: Transition.fade),
        icon: const Icon(
          Iconsax.add_copy,
          size: 18,
          color: TColors.white,
        ),
        label: const Text("Customer"),
      ),
    );
  }
}
