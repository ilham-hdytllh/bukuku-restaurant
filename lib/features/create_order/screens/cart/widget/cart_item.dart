import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/cart_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

// ignore: must_be_immutable
class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Obx(
      () => ClipRRect(
        child: Padding(
          padding: const EdgeInsets.only(top: TSizes.spaceBtwText),
          child: Slidable(
            closeOnScroll: true,
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) =>
                      cartController.removeItemInCart(index),
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                  backgroundColor: TColors.error,
                  foregroundColor: TColors.white,
                  icon: Iconsax.trash,
                ),
              ],
            ),
            child: Container(
              height: 130,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.1),
                border: const Border(
                  top: BorderSide(width: 3, color: TColors.primary),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartController.cartItem[index].menuName
                            .toString()
                            .capitalizeAll(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Rp ${cartController.cartItem[index].price.toString()}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwText,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.note_2,
                            size: TSizes.iconSm,
                            color: TColors.darkGrey,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwText,
                          ),
                          Text(
                            "Note : ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwText,
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Text(
                                cartController.cartItem[index].note.isEmpty
                                    ? "-"
                                    : cartController.cartItem[index].note,
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwText,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Iconsax.edit_2_copy,
                            size: TSizes.iconMd,
                            color: TColors.primary,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwText,
                          ),
                          Text(
                            "edit".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: TColors.primary),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartController.cartItem[index].quantity <=
                                  1) {
                                cartController.removeItemInCart(index);
                              } else {
                                cartController.decrementQtyInCart(index);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: TColors.grey,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(width: 1, color: TColors.grey),
                              ),
                              width: 35,
                              height: 35,
                              child:
                                  cartController.cartItem[index].quantity <= 1
                                      ? const Icon(
                                          Iconsax.trash_copy,
                                          size: 20,
                                          color: TColors.black,
                                        )
                                      : const Icon(
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
                                cartController.cartItem[index].quantity
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cartController.incrementQtyInCart(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: TColors.grey,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(width: 1, color: TColors.grey),
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
                    ],
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
