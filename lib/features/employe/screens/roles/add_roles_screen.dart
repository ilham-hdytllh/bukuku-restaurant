import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/styles/constraint_input_field.dart';
import 'package:restaurant_bukuku/common/widgets/custom_form/custom_form_field.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/remove_alert_content/remove_alert_content.dart';
import 'package:restaurant_bukuku/features/employe/controller/roles/roles_controller.dart';
import 'package:restaurant_bukuku/features/employe/screens/roles/widgets/chip_permission.dart';
import 'package:restaurant_bukuku/features/employe/screens/roles/widgets/permission_checkbox.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class AddRolesScreen extends StatelessWidget {
  const AddRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roleController = Get.put(RoleController());

    return Scaffold(
      backgroundColor: TColors.softGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () => Get.back(id: 4),
                          icon: const Icon(
                            Iconsax.arrow_left_copy,
                            size: 28,
                            color: TColors.primary,
                          )),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: TColors.white,
                        ),
                        child: Form(
                          key: roleController.roleFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: "Role Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                          children: [
                                        TextSpan(
                                            text: ' *',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color: TColors.primary))
                                      ])),
                                  const SizedBox(
                                    height: TSizes.spaceBtwInputFields - 8,
                                  ),
                                  Obx(
                                    () => Container(
                                      constraints:
                                          TConstraints.inputFieldConstraint,
                                      child: TextFormField(
                                        autofocus: false,
                                        keyboardType: TextInputType.text,
                                        controller:
                                            roleController.roleName.value,
                                        validator: (value) =>
                                            TValidator.validateEmptyText(
                                                "Role Name", value),
                                        decoration: const InputDecoration(
                                            hintText: "Ex: Head Branch"),
                                        style: const TextStyle().copyWith(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal),
                                        onTapOutside: (value) =>
                                            FocusScope.of(context).unfocus(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwItems,
                              ),
                              Expanded(
                                child: GetBuilder<RoleController>(
                                  builder: (controller) => CustomFormField(
                                    roleController: controller,
                                    initialValue:
                                        controller.anyPermissionSelected(),
                                    autovalidateMode: AutovalidateMode.disabled,
                                    validator: (value) =>
                                        TValidator.validateEmptyCheckbox(
                                            "Please choose one",
                                            controller.anyPermissionSelected()),
                                    page: const PermissionCheckbox(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwItems,
                              ),
                              Obx(
                                () => Visibility(
                                  visible: !roleController.updateActive.value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: TSizes.inputFieldHeight,
                                      child: Obx(
                                        () => ElevatedButton(
                                          onPressed: roleController
                                                      .isLoadingAdd.value ==
                                                  false
                                              ? () => roleController
                                                  .saveRoleRecord()
                                              : null,
                                          child: roleController
                                                      .isLoadingAdd.value ==
                                                  false
                                              ? Text("add".tr)
                                              : const Center(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 26,
                                                        width: 26,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              TColors.darkGrey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Please wait..."),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: roleController.updateActive.value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: TSizes.inputFieldHeight,
                                      child: Obx(
                                        () => ElevatedButton(
                                          onPressed: roleController
                                                      .isLoadingUpdate.value ==
                                                  false
                                              ? () => roleController
                                                  .updateRoleRecord()
                                              : null,
                                          child: roleController
                                                      .isLoadingUpdate.value ==
                                                  false
                                              ? Text("edit".tr)
                                              : const Center(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 26,
                                                        width: 26,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              TColors.darkGrey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Please wait..."),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => SizedBox(
                                  height:
                                      roleController.updateActive.value == true
                                          ? TSizes.spaceBtwText
                                          : 0,
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: roleController.updateActive.value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: TSizes.inputFieldHeight,
                                      child: OutlinedButton(
                                          onPressed: () =>
                                              roleController.cancelUpdateView(),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: TColors.primary),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 48,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (roleController.isLoadingGet.value == true) {
                              return SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: DataTable(
                                        dataRowMaxHeight: 150,
                                        dataRowMinHeight: 60,
                                        columns: const [
                                          DataColumn(
                                            label: Text(
                                              'No',
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Name Role',
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Permission',
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Aksi',
                                            ),
                                          ),
                                        ],
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
                                        child:
                                            TLoader.customCircularProgress()),
                                  ],
                                ),
                              );
                            } else if (roleController.allRoles.isEmpty) {
                              return SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: DataTable(
                                        dataRowMaxHeight: 150,
                                        dataRowMinHeight: 60,
                                        columns: const [
                                          DataColumn(
                                            label: Text(
                                              'No',
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Name Role',
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Permission',
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Aksi',
                                            ),
                                          ),
                                        ],
                                        rows: const [],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: TColors.grey),
                                          color: TColors.white,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      height: 220,
                                      child: EmptyItem(
                                        text: "No Role",
                                        desciption: "No Role in the list",
                                        fit: BoxFit.fitWidth,
                                        picture: Image.asset(
                                          TImages.staffIcon,
                                          height: 90,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Obx(
                              () => SizedBox(
                                width: double.infinity,
                                child: DataTable(
                                  dataRowMaxHeight: 150,
                                  dataRowMinHeight: 60,
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        'No',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Name Role',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Permission',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Aksi',
                                      ),
                                    ),
                                  ],
                                  rows: roleController.allRoles.map((element) {
                                    return DataRow(cells: [
                                      DataCell(
                                        Text(
                                          (roleController.allRoles
                                                      .indexOf(element) +
                                                  1)
                                              .toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          element.roleName
                                              .toString()
                                              .capitalizeSingle(),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: 300,
                                          child: Wrap(
                                            runSpacing: 0,
                                            spacing: 3,
                                            children: [
                                              ChipPermission(
                                                label: "Branch",
                                                visibility: element
                                                    .permissions["branch"]!,
                                              ),
                                              ChipPermission(
                                                label: "Create Order",
                                                visibility: element.permissions[
                                                    "create_order"]!,
                                              ),
                                              ChipPermission(
                                                label: "Customer",
                                                visibility: element
                                                    .permissions["customer"]!,
                                              ),
                                              ChipPermission(
                                                label: "Inventory",
                                                visibility: element
                                                    .permissions["inventory"]!,
                                              ),
                                              ChipPermission(
                                                label: "Menu",
                                                visibility: element
                                                    .permissions["menu"]!,
                                              ),
                                              ChipPermission(
                                                label: "Order",
                                                visibility: element
                                                    .permissions["order"]!,
                                              ),
                                              ChipPermission(
                                                label: "Promotion",
                                                visibility: element
                                                    .permissions["promotion"]!,
                                              ),
                                              ChipPermission(
                                                label: "Report",
                                                visibility: element
                                                    .permissions["report"]!,
                                              ),
                                              ChipPermission(
                                                label: "Staff",
                                                visibility: element
                                                    .permissions["staff"]!,
                                              ),
                                              ChipPermission(
                                                label: "Table",
                                                visibility: element
                                                    .permissions["table"]!,
                                              ),
                                            ],
                                          ),
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
                                              onPressed: () =>
                                                  roleController.setUpdateView(
                                                      element.roleName,
                                                      element.roleID,
                                                      element.permissions.obs),
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
                                                CustomDialog.confirmationDialog(
                                                  (THelperFunctions
                                                          .screenWidth() *
                                                      0.45),
                                                  roleController.isLoadingDelete
                                                              .value ==
                                                          false
                                                      ? () => roleController
                                                          .deleteRoleRecord(
                                                              element.roleID)
                                                      : () {},
                                                  "delete".tr,
                                                  "confirmation".tr,
                                                  const RemoveAlertContent(
                                                    title:
                                                        "Yakin ingin menghapus role ?",
                                                    subTitle:
                                                        "Pastikan sebelum menghapus role ini sudah tidak ada staff yang memakai role ini..",
                                                  ),
                                                  Iconsax.trash_copy,
                                                  TColors.error,
                                                  roleController
                                                      .isLoadingDelete.value,
                                                );
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
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
