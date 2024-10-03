import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/category_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/category/widgets/category_form.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class NavigateButtonAddCategoryScreen extends StatelessWidget {
  const NavigateButtonAddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return SizedBox(
      height: TSizes.inputFieldHeight,
      child: ElevatedButton.icon(
        onPressed: () {
          CustomDialog.tabletDialog(
              (THelperFunctions.screenWidth() * 0.45),
              categoryController.isLoadingAdd.value == false
                  ? () => categoryController.saveCategoryRecord()
                  : () {},
              "save".tr,
              "Category",
              const CategoryForm(),
              true,
              categoryController.isLoadingUpdate.value);
        },
        icon: const Icon(
          Iconsax.add,
          size: TSizes.iconSm,
          color: TColors.white,
        ),
        label: const Text("Category"),
      ),
    );
  }
}
