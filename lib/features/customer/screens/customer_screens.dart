import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/features/customer/controllers/customer_controller.dart';
import 'package:restaurant_bukuku/features/customer/screens/customer_update_screen.dart';
import 'package:restaurant_bukuku/features/customer/screens/widgets/add_customer_button.dart';
import 'package:restaurant_bukuku/features/customer/screens/widgets/remove_customer_content_dialog.dart';
import 'package:restaurant_bukuku/features/customer/screens/widgets/search_customer.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerController = Get.put(CustomerController());
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
                  // Search customer
                  SearchCustomer(),
                  // Add customer button
                  AddCustomerButton(),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return DataTable(
                    columns: [
                      const DataColumn(
                        label: Text(
                          'No',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'customerName'.tr,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'customerID'.tr,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'email'.tr,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'phoneNo'.tr,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'action'.tr,
                        ),
                      ),
                    ],
                    rows: customerController.allCustomerToTable.map((element) {
                      return DataRow(cells: [
                        DataCell(
                          Text(
                            (customerController.allCustomerToTable
                                        .indexOf(element) +
                                    1)
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            element.customerName.toString().capitalizeAll(),
                          ),
                        ),
                        DataCell(
                          Text(
                            element.customerID,
                          ),
                        ),
                        DataCell(
                          Text(
                            element.email,
                          ),
                        ),
                        DataCell(
                          Text(
                            element.phoneNumber.isNotEmpty
                                ? "${element.dialCode}${element.phoneNumber}"
                                : "-",
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
                                  customerController.setVariableToUpdate(
                                      element.customerID,
                                      element.customerName,
                                      element.dialCode,
                                      element.phoneNumber,
                                      element.email,
                                      element.birthdayDate,
                                      element.address,
                                      element.province,
                                      element.city,
                                      element.district);

                                  Get.to(const UpdateCustomerScreen(),
                                      id: 8,
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
                                    customerController.isLoadingDelete.value ==
                                            false
                                        ? () => customerController
                                            .deleteCustomerRecord(
                                                element.customerID)
                                        : () {},
                                    "delete".tr,
                                    "confirmation".tr,
                                    const RemoveCustomerContentDialog(),
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
                }),
              ),
              Obx(
                () {
                  return customerController.allCustomerToTable.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: TColors.grey),
                              color: TColors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          height: 220,
                          child: EmptyItem(
                            text: "No Customer",
                            desciption: "No customer in the list",
                            fit: BoxFit.fitWidth,
                            picture: Image.asset(
                              TImages.staffIcon,
                              height: 90,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
