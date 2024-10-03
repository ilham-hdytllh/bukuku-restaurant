import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/remove_alert_content/remove_alert_content.dart';
import 'package:restaurant_bukuku/common/widgets/select_role/select_role_content.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/employe/controller/employes/employee_controller.dart';
import 'package:restaurant_bukuku/features/employe/screens/employe/add_employe_screen.dart';
import 'package:restaurant_bukuku/features/employe/screens/employe/update_employe_screen.dart';
import 'package:restaurant_bukuku/features/employe/screens/roles/add_roles_screen.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class EmployeScreen extends StatelessWidget {
  const EmployeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeController = Get.put(EmployeController());
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // search staff
                  SizedBox(
                      width: THelperFunctions.screenWidth() * 0.4,
                      child: SearchTextField(
                        hintText: "searchStaffHintText".tr,
                        onChanged: (value) => employeController.orderBySearch(),
                        controller: employeController.searchEmploye.value,
                      )),
                  const Spacer(),
                  // tambah staff
                  SizedBox(
                    height: TSizes.inputFieldHeight,
                    child: ElevatedButton.icon(
                      onPressed: () => Get.to(const AddEmployeScreen(),
                          id: 4,
                          duration: const Duration(milliseconds: 500),
                          transition: Transition.fade),
                      icon: const Icon(
                        Iconsax.add_copy,
                        size: 18,
                        color: TColors.white,
                      ),
                      label: Text("staff".tr),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  // setup role
                  SizedBox(
                    height: TSizes.inputFieldHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.black),
                      onPressed: () => Get.to(const AddRolesScreen(),
                          id: 4,
                          duration: const Duration(milliseconds: 500),
                          transition: Transition.fade),
                      child: Text("roleSetup".tr),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: employeController.employeRole,
                    readOnly: true,
                    onTap: () {
                      CustomDialog.tabletDialog(
                          (THelperFunctions.screenWidth() * 0.45),
                          () {},
                          "Select",
                          "Role",
                          SelectRoleContent(
                            controller: employeController.employeRole,
                          ),
                          false);
                    },
                    style: const TextStyle().copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      fillColor: TColors.white,
                      filled: true,
                      hintText: "allRole".tr,
                      suffixIcon: const Icon(
                        Iconsax.arrow_square_down_copy,
                        size: TSizes.iconMd,
                        color: TColors.darkGrey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems - 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'allowStafLogin'.tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Switch(
                      activeColor: TColors.primary,
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems - 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  if (employeController.isLoadingGet.value == true) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              dividerThickness: 0.5,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: TColors.grey),
                                  color: TColors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              headingTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: TColors.black),
                              dataTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                                    'name'.tr,
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'email'.tr,
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    'Role',
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'branch'.tr,
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'action'.tr,
                                  ),
                                ),
                              ],
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
                  } else if (employeController.allEmployeToTable.isEmpty) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              dividerThickness: 0.5,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: TColors.grey),
                                  color: TColors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              headingTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: TColors.black),
                              dataTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                                    'name'.tr,
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'email'.tr,
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    'Role',
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'branch'.tr,
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'action'.tr,
                                  ),
                                ),
                              ],
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
                  } else {
                    return SizedBox(
                      width: double.infinity,
                      child: DataTable(
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
                              'name'.tr,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'email'.tr,
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              'Role',
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'branch'.tr,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'action'.tr,
                            ),
                          ),
                        ],
                        rows:
                            employeController.allEmployeToTable.map((element) {
                          return DataRow(cells: [
                            DataCell(
                              Text(
                                (employeController.allEmployeToTable
                                            .indexOf(element) +
                                        1)
                                    .toString(),
                              ),
                            ),
                            DataCell(
                              Text(
                                element.employeName.toString().capitalizeAll(),
                              ),
                            ),
                            DataCell(
                              Text(
                                element.employeEmail.toString(),
                              ),
                            ),
                            DataCell(
                              Text(
                                element.role.toString().capitalizeAll(),
                              ),
                            ),
                            DataCell(
                              Text(
                                element.branchID.toString(),
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
                                      employeController.setVariableToUpdate(
                                        element.employeID,
                                        element.employeName,
                                        element.employeEmail,
                                        element.role,
                                        element.pin,
                                      );
                                      Get.to(const UpdateEmployeScreen(),
                                          id: 4,
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
                                        employeController
                                                    .isLoadingDelete.value ==
                                                false
                                            ? () => employeController
                                                .deleteEmployeRecord(
                                                    element.employeID,
                                                    element.role)
                                            : () {},
                                        "delete".tr,
                                        "confirmation".tr,
                                        const RemoveAlertContent(
                                          title:
                                              "Yakin ingin menghapus staff ?",
                                          subTitle:
                                              "Pastikan sebelum menghapus staff ini sudah tidak ada branch yang memakai staff ini..",
                                        ),
                                        Iconsax.trash_copy,
                                        TColors.error,
                                        employeController.isLoadingDelete.value,
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
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
