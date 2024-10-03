import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/custom_back_button/custom_back_button.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/cart_controller.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/navigation/controllers/appbar/appbar_controller.dart';
import 'package:restaurant_bukuku/features/payment/controllers/cekout_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/currencyformat.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class CekoutScreen extends StatelessWidget {
  const CekoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cekoutController = Get.put(CekoutController());
    final cartController = Get.put(CartController());
    final createOrderController = Get.put(CreateOrderController());
    final employeActiveController = Get.put(AppBarController());
    return Scaffold(
      backgroundColor: TColors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: TColors.white,
              width: THelperFunctions.screenWidth() * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: TSizes.spaceBtwText,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: CustomBackButton(
                      onTap: () => Get.back(id: 0),
                    ),
                  ),
                  const Divider(
                    color: TColors.primary,
                    thickness: 3,
                  ),
                  Container(
                    color: TColors.softGrey,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: TSizes.spaceBtwText + 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "#1",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Obx(
                                () => Text(
                                  createOrderController.pax.value.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwText,
                        ),
                        const Divider(
                          color: TColors.grey,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Created Time",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Obx(
                                () => Text(
                                  cartController.dateAndTime.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sales Channel",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Obx(
                                () => Text(
                                  createOrderController.selectedSalesType.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Created By",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Obx(
                                () => Text(
                                  employeActiveController
                                      .employeNameActive.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "View Order Detail",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: TColors.primary),
                              ),
                              const Icon(
                                Iconsax.arrow_right_copy,
                                size: TSizes.iconMd,
                                color: TColors.primary,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwText + 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: TColors.white,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Obx(
                                () => Text(
                                  CurrencyFormat.convertToIdr(
                                      cartController.totalCartPrice.value, 0),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Promo Amount",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                "-Rp 0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                "Rp 0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Service Charge",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                "Rp 0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tax",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                "Rp 0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: TColors.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grand Total",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Obx(
                            () => Text(
                              CurrencyFormat.convertToIdr(
                                  cartController.totalCartPrice.value, 0),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  // CustomOutlinedButton(
                  //   height: TSizes.inputFieldHeight,
                  //   borderColor: TColors.primary,
                  //   child: Center(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         const Icon(
                  //           Iconsax.printer_copy,
                  //           size: TSizes.iconMd,
                  //         ),
                  //         const SizedBox(
                  //           width: TSizes.spaceBtwText,
                  //         ),
                  //         Text(
                  //           "Print Bill",
                  //           style: Theme.of(context).textTheme.bodyLarge,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: TSizes.spaceBtwItems,
                  // ),
                  const Divider(
                    color: TColors.primary,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwText,
                  ),
                  Text(
                    "Payment metode",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 1,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: createOrderController.paymentMethod.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          createOrderController.selectedPaymentMethod.value =
                              createOrderController.paymentMethod[index]
                                      ["payment"] ??
                                  "";
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 1, color: TColors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 3,
                                right: 3,
                                child: Obx(
                                  () => Radio(
                                      activeColor: TColors.primary,
                                      value: createOrderController
                                              .selectedPaymentMethod.value ==
                                          createOrderController
                                              .paymentMethod[index]["payment"],
                                      groupValue: createOrderController
                                              .selectedPaymentMethod.value ==
                                          createOrderController
                                              .paymentMethod[index]["payment"],
                                      onChanged: (value) {}),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      createOrderController.paymentMethod[index]
                                          ["image"],
                                      height: 35,
                                    ),
                                    const SizedBox(
                                      width: TSizes.spaceBtwText,
                                    ),
                                    Text(
                                      createOrderController.paymentMethod[index]
                                          ["payment"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: TSizes.inputFieldHeight,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () =>
                            createOrderController.saveOrderToFirestore(),
                        child: cekoutController.isLoadingAdd.value == false
                            ? Text("Pay".tr)
                            : const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 26,
                                      width: 26,
                                      child: CircularProgressIndicator(
                                        color: TColors.darkGrey,
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
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
