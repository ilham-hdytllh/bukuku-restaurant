import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/appname/appname.dart';
import 'package:restaurant_bukuku/common/widgets/search/search_basic.dart';
import 'package:restaurant_bukuku/features/branch/controllers/branch_controller.dart';
import 'package:restaurant_bukuku/features/employe/controller/employes/employee_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/divider/horizontal_divider.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SelectBranchBody extends StatelessWidget {
  const SelectBranchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final branchController = Get.put(BranchController());
    final employeController = Get.put(EmployeController());
    return Container(
      decoration: BoxDecoration(
        color: isDark ? TColors.black : TColors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10), // Bentuk border
        boxShadow: [
          BoxShadow(
            color: TColors.darkGrey
                .withOpacity(0.5), // Warna bayangan dan tingkat kejernihan
            spreadRadius: 5, // Penyebaran bayangan
            blurRadius: 7, // Tingkat kabur bayangan
            offset: const Offset(0, 3), // Perpindahan bayangan dari objek
          ),
        ],
      ),
      width: THelperFunctions.screenWidth() < 900
          ? THelperFunctions.screenWidth() * 0.6
          : THelperFunctions.screenWidth() * 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpacePadding),
              child: Text(
                "Hi, ${employeController.selectedEmployeName.value}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwText,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpacePadding),
              child: Text(
                "Select outlet to continue",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: TSizes.defaultSpacePadding),
              child: SearchBasic(
                hintText: "Search name....",
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const CustomHorizontalDivider(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Obx(() {
              if (branchController.isLoadingGet.value == true) {
                return const Center(child: CircularProgressIndicator());
              } else if (branchController
                  .allBranchesFilteredCustomerID.isEmpty) {
                return Center(
                  child: Text(
                    "No branch found.",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpacePadding),
                itemCount:
                    branchController.allBranchesFilteredCustomerID.length,
                separatorBuilder: (context, index) =>
                    const CustomHorizontalDivider(),
                itemBuilder: (context, index) => ListTile(
                  onTap: () => BranchController.instance
                      .setBranchNameandNavigateToMainNavigation(
                    branchController
                        .allBranchesFilteredCustomerID[index].branchID,
                    branchController
                        .allBranchesFilteredCustomerID[index].branchName,
                    branchController
                        .allBranchesFilteredCustomerID[index].branchAddress,
                    branchController
                        .allBranchesFilteredCustomerID[index].branchDialCode,
                    branchController
                        .allBranchesFilteredCustomerID[index].branchPhoneNo,
                  ),
                  title: Text(
                    branchController
                        .allBranchesFilteredCustomerID[index].branchName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Obx(
                    () => Text(
                      employeController.selectedEmployeName.value,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: TColors.darkGrey),
                    ),
                  ),
                  trailing: const Icon(
                    Iconsax.arrow_right_2_copy,
                    color: TColors.primary,
                  ),
                ),
              );
            }),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const CustomHorizontalDivider(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const Align(alignment: Alignment.center, child: AppName()),
          ],
        ),
      ),
    );
  }
}
