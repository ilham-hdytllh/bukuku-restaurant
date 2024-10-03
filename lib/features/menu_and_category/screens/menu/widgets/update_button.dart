import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/menu_controller.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';

class UpdateMenuButton extends StatelessWidget {
  const UpdateMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(MenuProductController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: TSizes.inputFieldHeight,
        child: Obx(
          () => ElevatedButton(
            onPressed: menuController.isLoadingUpdate.value == false
                ? () => menuController
                    .updateMenuRecord(menuController.selectedMenuID.value)
                : () {},
            child: menuController.isLoadingUpdate.value == false
                ? Text("edit".tr)
                : TLoader.loaderButton(),
          ),
        ),
      ),
    );
  }
}
