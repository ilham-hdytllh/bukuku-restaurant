import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SelectAccountHeader extends StatelessWidget {
  const SelectAccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(Get.context!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo App
          Image(
            height: 60,
            image: AssetImage(
              isDark ? TImages.darkAppLogo : TImages.lightAppLogo,
            ),
            fit: BoxFit.fitHeight,
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
