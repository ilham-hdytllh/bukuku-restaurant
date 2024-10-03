import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/choose_table_by_group.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/choose_table_group.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class ChooseTableDialog extends StatelessWidget {
  const ChooseTableDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final createOrderController = Get.put(CreateOrderController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          RichText(
              text: TextSpan(
                  text: "Table Group",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                TextSpan(
                    text: '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: TColors.primary))
              ])),
          const SizedBox(
            height: TSizes.spaceBtwInputFields - 8,
          ),
          TextFormField(
            readOnly: true,
            controller: createOrderController.tableGroupSelected,
            onTap: () {
              CustomDialog.tabletDialog(
                (THelperFunctions.screenWidth() * 0.4),
                () {
                  Get.back();
                },
                "",
                "Choose Table Group",
                const ChooseTableGroupDialog(),
                false,
              );
            },
            decoration: const InputDecoration(
              hintText: "Choose Table Group",
              suffixIcon: Icon(
                Iconsax.arrow_square_down_copy,
                color: TColors.darkGrey,
              ),
            ),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          RichText(
              text: TextSpan(
                  text: "Table",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                TextSpan(
                    text: '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: TColors.primary))
              ])),
          const SizedBox(
            height: TSizes.spaceBtwInputFields - 8,
          ),
          TextFormField(
            readOnly: true,
            controller: createOrderController.tableSelected,
            onTap: () {
              createOrderController.selectedTableGroupID.isNotEmpty
                  ? CustomDialog.tabletDialog(
                      (THelperFunctions.screenWidth() * 0.4),
                      () {
                        Get.back();
                      },
                      "",
                      "Choose Table",
                      const ChooseTableOrderByGroupDialog(),
                      false,
                    )
                  : null;
            },
            decoration: const InputDecoration(
              hintText: "Choose Table",
              suffixIcon: Icon(
                Iconsax.arrow_square_down_copy,
                color: TColors.darkGrey,
              ),
            ),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          RichText(
              text: TextSpan(
                  text: "Pax",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                TextSpan(
                    text: '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: TColors.primary))
              ])),
          const SizedBox(
            height: TSizes.spaceBtwInputFields - 8,
          ),
          Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (createOrderController.pax.value <= 1) {
                      null;
                    } else {
                      createOrderController.pax.value--;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.grey,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: TColors.grey),
                    ),
                    width: 35,
                    height: 35,
                    child: const Icon(
                      Icons.remove,
                      size: 20,
                      color: TColors.black,
                    ),
                  ),
                ),
                Container(
                  height: 35,
                  width: 90,
                  color: TColors.softGrey,
                  child: Center(
                    child: Text(
                      "${createOrderController.pax}",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => createOrderController.pax.value++,
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.grey,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: TColors.grey),
                    ),
                    width: 35,
                    height: 35,
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      color: TColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
