import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/cart_page.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/button_change_ui_menulist.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/button_filter_category.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/button_promo_menu.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/button_all_menu.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/menu_listview.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/menu_wrap_view.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/textfield_search_menu.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/divider/vertical_divider.dart';

class MenuOrderPage extends StatelessWidget {
  const MenuOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: TSizes.spaceBtwItems - 15,
                ),
                // Search menu
                const TextfieldSearchMenu(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Button get all menu
                    ButtonAllMenu(),
                    SizedBox(
                      width: 8,
                    ),
                    // Button get promo menu
                    ButtonPromoMenu(),
                    SizedBox(
                      width: 8,
                    ),
                    // Button filtered by category
                    ButtonFilteredCategory(),
                    SizedBox(
                      width: 8,
                    ),
                    // Button change ui menu list wrap to listing listview
                    ButtonChangeUIMenuList(),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems - 10,
                ),
                // Menu list using wrap or listview
                Obx(
                  () => controller.wrapOrNo.value
                      ? const MenuWrapView()
                      : const MenuListView(),
                ),
              ],
            ),
          ),
        ),
        const CustomVerticalDivider(),
        const CartPage(),
      ],
    );
  }
}
