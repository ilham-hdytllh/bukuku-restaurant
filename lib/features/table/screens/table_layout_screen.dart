import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/custom_outlined_button/custom_outlined_button.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/dragable_tablea.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/form_add_object_other.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/form_add_table_object.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/select_table_group.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class TableLayoutScreen extends StatelessWidget {
  const TableLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tableController = Get.put(TableController());
    return Column(
      children: [
        Row(
          children: [
            // dropddown table group table
            SizedBox(
              width: THelperFunctions.screenWidth() * 0.16,
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  CustomDialog.tabletDialog(
                    (THelperFunctions.screenWidth() * 0.4),
                    () {
                      Get.back();
                    },
                    "",
                    "Select Table",
                    const SelectTableGroupDialog(),
                    false,
                  );
                },
                controller: tableController.groupTableNameController,
                style: const TextStyle()
                    .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                onTapOutside: (value) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: TColors.white,
                  suffixIcon: Icon(
                    Iconsax.arrow_square_down_copy,
                    size: TSizes.iconMd,
                    color: TColors.darkGrey,
                  ),
                ),
              ),
            ),
            // edit,save,add table,add object button
            const Spacer(),
            Obx(
              () => tableController.editLayout.value == true
                  ? GestureDetector(
                      onTap: () {
                        CustomDialog.tabletDialog(
                            (THelperFunctions.screenWidth() * 0.45), () {
                          tableController.addObject();
                          tableController.capacity.value = 1;
                        }, "save".tr, "Add Object", const FormAddObject(), true,
                            tableController.isLoadingAdd.value);
                      },
                      child: CustomOutlinedButton(
                        borderColor: TColors.primary,
                        height: TSizes.inputFieldHeight,
                        child: Text(
                          "Add Object",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.primary),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => tableController.editLayout.value == true
                  ? const SizedBox(
                      width: TSizes.spaceBtwText,
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => tableController.editLayout.value == true
                  ? SizedBox(
                      height: TSizes.inputFieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.black),
                        onPressed: () {
                          CustomDialog.tabletDialog(
                              (THelperFunctions.screenWidth() * 0.45), () {
                            tableController.addObjectTable();
                            tableController.capacity.value = 1;
                          }, "save".tr, "Add Table", const FormAddTableObject(),
                              true, tableController.isLoadingAdd.value);
                        },
                        child: Text(
                          "Add Table",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => tableController.editLayout.value == true
                  ? const SizedBox(
                      width: 60,
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => tableController.editLayout.value == true
                  ? SizedBox(
                      height: TSizes.inputFieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.error),
                        onPressed: () => tableController.cancelUpdateLayout(),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => tableController.editLayout.value == true
                  ? const SizedBox(
                      width: TSizes.spaceBtwText,
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => tableController.editLayout.value == true
                  ? SizedBox(
                      height: TSizes.inputFieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary),
                        onPressed: () => tableController.saveLayoutTable(),
                        child: Text(
                          "Save",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),

            Obx(
              () => tableController.editLayout.value == false
                  ? SizedBox(
                      height: TSizes.inputFieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.black),
                        onPressed: () => tableController.editLayout.value =
                            !tableController.editLayout.value,
                        child: Text(
                          "Edit Layout",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: TColors.white, borderRadius: BorderRadius.circular(5)),
            child: Obx(() {
              if (tableController.isLoadingGet.value == true) {
                return Center(child: TLoader.customCircularProgress());
              } else if (tableController.allGroupTableForView.isEmpty) {
                return Center(
                  child: EmptyItem(
                    text: "No Table",
                    desciption: "No Table in the list",
                    fit: BoxFit.fitWidth,
                    picture: Image.asset(
                      TImages.tableIcon,
                      height: 90,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              } else {
                return Container(
                  color: TColors.white,
                  width: double.infinity,
                  height: double.infinity,
                  child: const GestureTable(),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}
