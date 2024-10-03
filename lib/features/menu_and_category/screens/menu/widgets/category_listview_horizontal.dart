import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/custom_outlined_button/custom_outlined_button.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/category_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/menu_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class CategoryListHorizontal extends StatelessWidget {
  const CategoryListHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final menuProductController = Get.put(MenuProductController());
    return Obx(
      () => ListView.builder(
        itemCount: categoryController.allCategory.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: TSizes.spaceBtwInputFields),
          child: Obx(
            () => GestureDetector(
              onTap: () {
                if (menuProductController.selectedCategoryFilter.value ==
                    categoryController.allCategory[index].categoryName) {
                  menuProductController.selectedCategoryFilter.value = "";
                  menuProductController.orderBySearch();
                } else {
                  menuProductController.selectedCategoryFilter.value =
                      categoryController.allCategory[index].categoryName;
                  menuProductController.orderBySearch();
                }
              },
              child: CustomOutlinedButton(
                height: TSizes.inputFieldHeight,
                borderColor:
                    menuProductController.selectedCategoryFilter.value !=
                            categoryController.allCategory[index].categoryName
                        ? TColors.darkGrey
                        : TColors.primary,
                child: Text(
                  categoryController.allCategory[index].categoryName
                      .toString()
                      .capitalizeAll(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: menuProductController
                                  .selectedCategoryFilter.value !=
                              categoryController.allCategory[index].categoryName
                          ? TColors.darkGrey
                          : TColors.primary),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
