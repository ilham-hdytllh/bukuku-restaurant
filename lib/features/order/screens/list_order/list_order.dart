import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/custom_outlined_button/custom_outlined_button.dart';
import 'package:restaurant_bukuku/features/order/controllers/order_controller.dart';
import 'package:restaurant_bukuku/features/order/screens/detail_order/detail_order.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class ListOrderScreen extends StatelessWidget {
  const ListOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return Row(
      children: [
        SizedBox(
          width: THelperFunctions.screenWidth() * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.setting,
                        color: TColors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.black,
                      ),
                      label: Text(
                        "Action",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: TColors.white),
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),
                    Text(
                      "Riwayat",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: TColors.primary),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: TSizes.spaceBtwInputFields),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          height: TSizes.inputFieldHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: TColors.darkGrey,
                            ),
                          ),
                          child: const Icon(
                            Iconsax.setting_4_copy,
                            size: 24,
                            color: TColors.darkGrey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => orderController.setFilterData("All"),
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                right: TSizes.spaceBtwInputFields),
                            child: CustomOutlinedButton(
                              height: TSizes.inputFieldHeight,
                              borderColor:
                                  orderController.filterSalesType.value == "All"
                                      ? TColors.primary
                                      : TColors.darkGrey,
                              child: Text(
                                "All",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: orderController
                                                    .filterSalesType.value ==
                                                "All"
                                            ? TColors.primary
                                            : TColors.darkGrey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => orderController.setFilterData("Dine In"),
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                right: TSizes.spaceBtwInputFields),
                            child: CustomOutlinedButton(
                              height: TSizes.inputFieldHeight,
                              borderColor:
                                  orderController.filterSalesType.value ==
                                          "Dine In"
                                      ? TColors.primary
                                      : TColors.darkGrey,
                              child: Text(
                                "Dine In",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: orderController
                                                    .filterSalesType.value ==
                                                "Dine In"
                                            ? TColors.primary
                                            : TColors.darkGrey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => orderController.setFilterData("Take Away"),
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                right: TSizes.spaceBtwInputFields),
                            child: CustomOutlinedButton(
                              height: TSizes.inputFieldHeight,
                              borderColor:
                                  orderController.filterSalesType.value ==
                                          "Take Away"
                                      ? TColors.primary
                                      : TColors.darkGrey,
                              child: Text(
                                "Take Away",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: orderController
                                                    .filterSalesType.value ==
                                                "Take Away"
                                            ? TColors.primary
                                            : TColors.darkGrey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Menampilkan ${orderController.orderFilteredData.length} Hasil",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: TColors.darkGrey),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: orderController.orderFilteredData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => orderController.setOrderDetail(index),
                        child: Obx(
                          () => Container(
                            height: 80,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: orderController.idOrder.value ==
                                        orderController
                                            .orderFilteredData[index].orderID
                                    ? Colors.orangeAccent.withOpacity(0.1)
                                    : Colors.transparent,
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                        width: 0.5,
                                        color: orderController.idOrder.value ==
                                                orderController
                                                    .orderFilteredData[index]
                                                    .orderID
                                            ? TColors.primary
                                            : TColors.darkGrey))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  orderController.orderFilteredData[index].pax
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: orderController
                                                      .idOrder.value ==
                                                  orderController
                                                      .orderFilteredData[index]
                                                      .orderID
                                              ? TColors.primary
                                              : TColors.darkGrey),
                                ),
                                CustomOutlinedButton(
                                  height: TSizes.inputFieldHeight - 10,
                                  borderColor: TColors.primary,
                                  child: Text(
                                    orderController
                                        .orderFilteredData[index].salesType,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: TColors.primary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: TSizes.defaultSpace,
        ),
        Obx(() => orderController.idOrder.isEmpty
            ? const SizedBox()
            : const DetailOrder()),
      ],
    );
  }
}
