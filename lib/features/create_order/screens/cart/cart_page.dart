import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/cart_controller.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/cart_item.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/pick_table.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/pick_sales_type.dart';
import 'package:restaurant_bukuku/common/widgets/custom_outlined_button/custom_outlined_button.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/print_qr_selforder.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/textfield_customer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: TSizes.spaceBtwItems - 15,
            ),
            const Row(
              children: [
                // Textfield customer
                CustomTextfieldCustomer(),
                SizedBox(
                  width: 15,
                ),
                // Pick salestype
                PickSalesType(),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems - 5,
            ),
            const Row(
              children: [
                // Pick table
                PickTable(),
                SizedBox(
                  width: 15,
                ),
                // Print qrcode to self order
                PrintQRCodeSelfOrder(),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems - 15,
            ),
            Expanded(
              child: Obx(() {
                if (cartController.cartItem.isEmpty) {
                  return SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: EmptyItem(
                      text: "Cart Empty",
                      desciption: "",
                      fit: BoxFit.fitWidth,
                      picture: Image.asset(
                        TImages.emptyCartIcon,
                        height: 90,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cartController.cartItem.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        index: index,
                      );
                    });
              }),
            ),
            SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return cartController.cartItem.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                  Obx(
                                    () => Text(
                                      "Rp ${cartController.totalCartPrice.value}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwText,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Expanded(
                                    child: CustomOutlinedButton(
                                      borderColor: TColors.primary,
                                      height: TSizes.inputFieldHeight,
                                      child: Text(
                                        "Open Bill",
                                        style:
                                            TextStyle(color: TColors.primary),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: TSizes.spaceBtwItems,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: TSizes.inputFieldHeight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          foregroundColor: TColors.light,
                                          backgroundColor: TColors.primary,
                                          disabledForegroundColor:
                                              TColors.darkGrey,
                                          disabledBackgroundColor:
                                              TColors.buttonDisabled,
                                          side: const BorderSide(
                                              color: TColors.primary),
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  TSizes.buttonHeight - 10,
                                              horizontal: 20),
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: TColors.textWhite,
                                              fontWeight: FontWeight.w600),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      TSizes.buttonRadius)),
                                        ),
                                        onPressed: () => cartController
                                            .navigateToCekoutOrder(),
                                        child: const Text("Checkout"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwText,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox();
                }))
          ],
        ),
      ),
    );
  }
}
