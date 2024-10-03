import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/custom_tapbar/custom_tapbar.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/remove_alert_content/remove_alert_content.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/menu_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/category/category_screen.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/menu_update_screen.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/widgets/navigate_add_menu_button.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/widgets/category_listview_horizontal.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/widgets/filter_menu_button.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/widgets/search_menu.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class MenuScreens extends StatelessWidget {
  const MenuScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(MenuProductController());
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: TColors.softGrey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: TColors.white,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomTapBar(
                    labelTab: ["Menu", "Category"],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // search menu
                              SearchMenu(),
                              // navigate to add menu screen
                              NavigateButtonAddMenuScreen(),
                            ],
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems - 6,
                          ),
                          const SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // filter menu button
                                FilterMenuButton(),
                                // category list
                                Expanded(
                                  child: CategoryListHorizontal(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Obx(() {
                              if (menuController.isLoadingGet.value == true) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: DataTable(
                                          columns:
                                              menuController.dataColumnLabel
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
                                              border: Border.all(
                                                  width: 1,
                                                  color: TColors.grey),
                                              color: TColors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5))),
                                          height: 220,
                                          child:
                                              TLoader.customCircularProgress()),
                                    ],
                                  ),
                                );
                              } else if (menuController
                                  .allMenuToTable.isEmpty) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: DataTable(
                                          columns:
                                              menuController.dataColumnLabel
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
                                            border: Border.all(
                                                width: 1, color: TColors.grey),
                                            color: TColors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5))),
                                        height: 220,
                                        child: EmptyItem(
                                          text: "No Menu",
                                          desciption: "No Menu in the list",
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
                                    columns: menuController.dataColumnLabel
                                        .map(
                                          (data) => DataColumn(
                                            label: Text(
                                              data,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    rows: menuController.allMenuToTable
                                        .map((element) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Text(
                                            (menuController.allMenuToTable
                                                        .indexOf(element) +
                                                    1)
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            element.menuName
                                                .toString()
                                                .capitalizeAll(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            element.price.toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            element.branchID,
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  menuController
                                                      .initializeDataUpdateToController(
                                                    element.menuID,
                                                    element.menuName,
                                                    element.menuImage,
                                                    element.category,
                                                    element.allowFlexiblePrice,
                                                    element.description,
                                                    element.price,
                                                    element.addons,
                                                    element.recipes,
                                                  );

                                                  Get.to(
                                                      const UpdateMenuScreen(),
                                                      id: 2,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      transition:
                                                          Transition.fade);
                                                },
                                                child: Text(
                                                  'edit'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: TColors.primary,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                ),
                                              ),
                                              const VerticalDivider(
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  CustomDialog
                                                      .confirmationDialog(
                                                          (THelperFunctions
                                                                  .screenWidth() *
                                                              0.45),
                                                          () => menuController
                                                              .deleteMenuRecord(
                                                                  element
                                                                      .menuID),
                                                          "delete".tr,
                                                          "confirmation".tr,
                                                          const RemoveAlertContent(
                                                            title:
                                                                "Yakin ingin menghapus menu ?",
                                                            subTitle:
                                                                "Menu yang telah di hapus tidak dapat di kembalikan..",
                                                          ),
                                                          Iconsax.trash_copy,
                                                          TColors.error,
                                                          menuController
                                                              .isLoadingDelete
                                                              .value);
                                                },
                                                child: Text(
                                                  'delete'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: TColors.error,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                        ],
                      ),
                    ),
                    const SingleChildScrollView(child: CategoryScreen()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
