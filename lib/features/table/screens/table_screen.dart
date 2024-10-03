import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/custom_tapbar/custom_tapbar.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/remove_alert_content/remove_alert_content.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/features/table/screens/table_layout_screen.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/form_table_group_content.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/button_add_group_table.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/search_group_table.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableController = Get.put(TableController());
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
                    labelTab: ["Group", "Layout"],
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
                              // search group table
                              SearchGroupTable(),
                              // show to add table group dialog
                              ButtonAddTableGroupDialog(),
                            ],
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Obx(() {
                              if (tableController.isLoadingGet.value == true) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: DataTable(
                                          columns:
                                              tableController.dataColumnLabel
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
                              } else if (tableController
                                  .allGroupTableForView.isEmpty) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: DataTable(
                                          columns:
                                              tableController.dataColumnLabel
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
                                          text: "No Table Group",
                                          desciption:
                                              "No Table Group in the list",
                                          fit: BoxFit.fitWidth,
                                          picture: Image.asset(
                                            TImages.tableIcon,
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
                                    columns: tableController.dataColumnLabel
                                        .map(
                                          (data) => DataColumn(
                                            label: Text(
                                              data,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    rows: tableController.allGroupTableForView
                                        .map((element) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Text(
                                            (tableController
                                                        .allGroupTableForView
                                                        .indexOf(element) +
                                                    1)
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            element.groupName
                                                .toString()
                                                .capitalizeAll(),
                                          ),
                                        ),
                                        DataCell(Switch(
                                            value: element.status,
                                            onChanged: (value) => tableController
                                                .updateStatusGroupTableRecord(
                                                    element.groupID,
                                                    !element.status))),
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
                                                  tableController
                                                      .initDataUpdate(
                                                          branchID:
                                                              element.branchID,
                                                          tableGroupID:
                                                              element.groupID,
                                                          tableGroupName:
                                                              element.groupName,
                                                          status:
                                                              element.status);
                                                  CustomDialog.tabletDialog(
                                                      (THelperFunctions
                                                              .screenWidth() *
                                                          0.45),
                                                      () => tableController
                                                          .updateGroupTableRecord(),
                                                      "edit".tr,
                                                      "Table",
                                                      const FormTableGroupContent(),
                                                      true,
                                                      tableController
                                                          .isLoadingUpdate
                                                          .value);
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
                                                          () => tableController
                                                              .deleteGroupTableRecord(
                                                                  element
                                                                      .groupID),
                                                          "delete".tr,
                                                          "confirmation".tr,
                                                          const RemoveAlertContent(
                                                            title:
                                                                "Yakin ingin menghapus group ini ?",
                                                            subTitle:
                                                                "Group yang telah di hapus tidak dapat di kembalikan..",
                                                          ),
                                                          Iconsax.trash_copy,
                                                          TColors.error,
                                                          tableController
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
                    const TableLayoutScreen(),
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
