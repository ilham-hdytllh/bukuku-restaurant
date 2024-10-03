import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/remove_alert_content/remove_alert_content.dart';
import 'package:restaurant_bukuku/features/branch/controllers/branch_controller.dart';
import 'package:restaurant_bukuku/features/branch/screens/update_branch_screen.dart';
import 'package:restaurant_bukuku/features/branch/screens/widget/add_branch_button.dart';
import 'package:restaurant_bukuku/features/branch/screens/widget/search_branch.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final branchController = Get.put(BranchController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: double.infinity,
      color: TColors.softGrey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwInputFields - 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Search branch
                  SearchBranch(),

                  // Add branch button
                  AddBranchButton(),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () {
                    return DataTable(
                      dividerThickness: 0.5,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: TColors.grey),
                          color: TColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      headingTextStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: TColors.black),
                      dataTextStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: TColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                      headingRowHeight: 50,
                      dataRowMaxHeight: 50,
                      dataRowMinHeight: 50,
                      columnSpacing: 5,
                      columns: [
                        const DataColumn(
                          label: Text(
                            'No',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'outletName'.tr,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'address'.tr,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'action'.tr,
                          ),
                        ),
                      ],
                      rows: branchController.searchBranches.map((element) {
                        return DataRow(cells: [
                          DataCell(
                            Text(
                              (branchController.searchBranches
                                          .indexOf(element) +
                                      1)
                                  .toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              element.branchName,
                            ),
                          ),
                          DataCell(
                            Text(
                              element.branchAddress,
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
                                    branchController
                                        .initializeDataUpdateToController(
                                      element.branchID,
                                      element.branchName,
                                      element.branchAddress,
                                      element.branchDialCode,
                                      element.branchPhoneNo,
                                      element.branchEmail,
                                    );
                                    Get.to(const UpdateBranchScreen(),
                                        id: 6,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        transition: Transition.fade);
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
                                      () => branchController
                                          .deleteBranchRecord(element.branchID),
                                      "delete".tr,
                                      "confirmation".tr,
                                      const RemoveAlertContent(
                                        title:
                                            "Yakin ingin mengahapus branch ?",
                                        subTitle:
                                            "Pastikan sebelum menghapus branch ini sudah tidak ada staff di dalamnya.",
                                      ),
                                      Iconsax.trash_copy,
                                      TColors.error,
                                    );
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
                    );
                  },
                ),
              ),
              Obx(() {
                return branchController.searchBranches.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: TColors.grey),
                            color: TColors.white,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        height: 220,
                        child: EmptyItem(
                          text: "No Branch",
                          desciption: "No branch in the list",
                          fit: BoxFit.fitWidth,
                          picture: Image.asset(
                            TImages.branchIcon,
                            height: 90,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
