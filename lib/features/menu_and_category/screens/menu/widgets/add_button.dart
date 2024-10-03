import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/menu_controller.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';

class AddMenuButton extends StatelessWidget {
  const AddMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(MenuProductController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: 120,
        height: TSizes.inputFieldHeight,
        child: Obx(
          () => ElevatedButton(
            onPressed: menuController.isLoadingAdd.value == false
                ? () => menuController.saveMenuRecord()
                : () {},
            child: menuController.isLoadingAdd.value == false
                ? Text("add".tr)
                : TLoader.loaderButton(),
          ),
        ),
      ),
    );
  }
}
