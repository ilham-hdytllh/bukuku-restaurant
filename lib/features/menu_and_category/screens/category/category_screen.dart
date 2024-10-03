import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/remove_alert_content/remove_alert_content.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/category_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/category/widgets/category_form.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/category/widgets/navigate_add_category_button.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/category/widgets/search_category.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // search category
              SearchCategory(),
              // navigate add category dialog
              NavigateButtonAddCategoryScreen(),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: double.infinity,
              child: Obx(() {
                if (categoryController.isLoadingGet.value == true) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: categoryController.dataColumnLabel
                                .map(
                                  (data) => DataColumn(
                                    label: Text(
                                      data,
                                    ),
                                  ),
                                )
                                .toList(),
                            rows: const [],
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: TColors.grey),
                                color: TColors.white,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            height: 220,
                            child: TLoader.customCircularProgress()),
                      ],
                    ),
                  );
                } else if (categoryController.allCategoryToTable.isEmpty) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: categoryController.dataColumnLabel
                                .map(
                                  (data) => DataColumn(
                                    label: Text(
                                      data,
                                    ),
                                  ),
                                )
                                .toList(),
                            rows: const [],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: TColors.grey),
                              color: TColors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          height: 220,
                          child: EmptyItem(
                            text: "No Category",
                            desciption: "No category in the list",
                            fit: BoxFit.fitWidth,
                            picture: Image.asset(
                              TImages.foodIcon,
                              height: 90,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columns: categoryController.dataColumnLabel
                          .map(
                            (data) => DataColumn(
                              label: Text(
                                data,
                              ),
                            ),
                          )
                          .toList(),
                      rows:
                          categoryController.allCategoryToTable.map((element) {
                        return DataRow(cells: [
                          DataCell(
                            Text(
                              (categoryController.allCategoryToTable
                                          .indexOf(element) +
                                      1)
                                  .toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              element.categoryName.toString().capitalizeAll(),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    categoryController
                                        .initializeDataUpdateToController(
                                            element.categoryID,
                                            element.categoryName);
                                    CustomDialog.tabletDialog(
                                        (THelperFunctions.screenWidth() * 0.45),
                                        categoryController
                                                    .isLoadingUpdate.value ==
                                                false
                                            ? () => categoryController
                                                .updateCategoryRecord(
                                                    element.categoryID)
                                            : () {},
                                        "save".tr,
                                        "Category",
                                        const CategoryForm(),
                                        true,
                                        categoryController
                                            .isLoadingUpdate.value);
                                  },
                                  child: Text(
                                    'edit'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: TColors.primary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                                const VerticalDivider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    CustomDialog.confirmationDialog(
                                        (THelperFunctions.screenWidth() * 0.45),
                                        categoryController
                                                    .isLoadingDelete.value ==
                                                false
                                            ? () => categoryController
                                                .deleteCategoryRecord(
                                                    element.categoryID)
                                            : () {},
                                        "delete".tr,
                                        "confirmation".tr,
                                        const RemoveAlertContent(
                                          title:
                                              "Yakin ingin menghapus category ?",
                                          subTitle:
                                              "Category yang telah di hapus tidak dapat di kembalikan..",
                                        ),
                                        Iconsax.trash_copy,
                                        TColors.error,
                                        categoryController
                                            .isLoadingDelete.value);
                                  },
                                  child: Text(
                                    'delete'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: TColors.error,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
