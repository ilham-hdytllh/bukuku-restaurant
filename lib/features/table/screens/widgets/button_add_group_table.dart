import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/form_table_group_content.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class ButtonAddTableGroupDialog extends StatelessWidget {
  const ButtonAddTableGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final tableController = Get.put(TableController());
    return SizedBox(
      height: TSizes.inputFieldHeight,
      width: 130,
      child: ElevatedButton.icon(
        onPressed: () {
          CustomDialog.tabletDialog(
              (THelperFunctions.screenWidth() * 0.45),
              () => tableController.saveGroupTableRecord(),
              "save".tr,
              "Table",
              const FormTableGroupContent(),
              true,
              tableController.isLoadingAdd.value);
        },
        icon: const Icon(
          Iconsax.add,
          size: TSizes.iconSm,
          color: TColors.white,
        ),
        label: const Text("Group"),
      ),
    );
  }
}
