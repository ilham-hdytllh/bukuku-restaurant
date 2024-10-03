import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/menu_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SearchMenu extends StatelessWidget {
  const SearchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(MenuProductController());
    return SizedBox(
      width: THelperFunctions.screenWidth() * 0.4,
      child: SearchTextField(
        controller: menuController.searchMenu,
        onChanged: (value) => menuController.orderBySearch(),
        hintText: "Cari menu..",
      ),
    );
  }
}
