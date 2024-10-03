import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/authentication/screens/select_account/select_account.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class SelectBranchHeader extends StatelessWidget {
  const SelectBranchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Switch User
          GestureDetector(
            onTap: () => Get.offAll(const SelectAccountScreen()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Iconsax.user_edit_copy,
                  color: TColors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Switch User",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: TColors.primary),
                ),
              ],
            ),
          ),
          // SignOut Button
          GestureDetector(
            onTap: () => AuthenticationRepository().logout(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Iconsax.logout_copy,
                  color: TColors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Sign Out",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: TColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
