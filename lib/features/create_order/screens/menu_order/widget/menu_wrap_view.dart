import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/cart_controller.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/card_menu_wrap.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/dialog_add_to_cart.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/shimmer_menu_wrap.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class MenuWrapView extends StatelessWidget {
  const MenuWrapView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    final cartController = Get.put(CartController());
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
          () {
            if (controller.isLoadingGet.value == true) {
              return const ShimmerMenuWrap();
            } else if (controller.allMenuToView.isEmpty) {
              return SizedBox(
                width: double.infinity,
                height: 300,
                child: EmptyItem(
                  text: "Menu Empty",
                  desciption: "No Menu in the list",
                  fit: BoxFit.fitWidth,
                  picture: Image.asset(
                    TImages.foodIcon,
                    height: 90,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              );
            }
            return SizedBox(
              width: double.infinity,
              child: Center(
                child: Wrap(
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  runSpacing: 15,
                  spacing: 15,
                  children: controller.allMenuToView.map((element) {
                    return GestureDetector(
                      onTap: () {
                        CustomDialog.tabletDialog(
                            THelperFunctions.screenWidth() * 0.5, () {
                          cartController.addItemToCart(element);
                        },
                            "save".tr,
                            "Menu",
                            AddToCart(
                              allowFlexiblePrice: element.allowFlexiblePrice,
                              image: element.menuImage,
                              name: element.menuName,
                              price: element.price,
                            ),
                            true);
                        controller.quantityItem.value = 1;
                        controller.price.text = element.price.toString();
                      },
                      child: CardMenuWrap(
                        image: element.menuImage,
                        name: element.menuName,
                        price: element.price,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
