import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/dialog_add_to_cart.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/widget/shimmer_menu_list.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class MenuListView extends StatelessWidget {
  const MenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return Expanded(child: Obx(() {
      if (controller.isLoadingGet.value == true) {
        return const ShimmerMenuList();
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
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.allMenuToView.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            CustomDialog.tabletDialog(
                THelperFunctions.screenWidth() * 0.5,
                () {},
                "save".tr,
                "Menu",
                AddToCart(
                  allowFlexiblePrice:
                      controller.allMenuToView[index].allowFlexiblePrice,
                  image: controller.allMenuToView[index].menuImage,
                  name: controller.allMenuToView[index].menuName,
                  price: controller.allMenuToView[index].price,
                ),
                true);
            controller.quantityItem.value = 1;
            controller.price.text =
                controller.allMenuToView[index].price.toString();
          },
          titleAlignment: ListTileTitleAlignment.center,
          leading: SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                controller.allMenuToView[index].menuImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            controller.allMenuToView[index].menuName.capitalizeAll(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: Text(
            "Rp ${controller.allMenuToView[index].price.toString()}",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }));
  }
}
