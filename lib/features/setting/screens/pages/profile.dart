import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/component/profile_name_update.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/features/setting/screens/widgets/profile/list_tile_profile.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    return Flexible(
      flex: 3,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Text(
              "Profil",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            const Divider(
              thickness: 5,
              color: TColors.primary,
            ),
            Obx(
              () => GestureDetector(
                onTap: () {
                  settingController.setEmployeNameToController(
                      settingController.employeNameActive.value);
                  CustomDialog.tabletDialog(
                    (THelperFunctions.screenWidth() * 0.5),
                    () async {
                      await settingController.updateProfileName();
                    },
                    "save".tr,
                    "Change Name",
                    const ChangeNameProfile(),
                    true,
                    settingController.isLoading.value,
                  );
                },
                child: ListTileProfile(
                    title: "Name",
                    content: settingController.employeNameActive.value,
                    edited: true),
              ),
            ),
            Obx(
              () => ListTileProfile(
                  title: "Email",
                  content: settingController.employeEmailActive.value,
                  edited: false),
            ),
            Obx(
              () => ListTileProfile(
                  title: "Role",
                  content: settingController.employeRoleActive.value
                      .capitalizeSingle(),
                  edited: false),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Delete Account",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: TColors.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
