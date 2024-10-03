import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';

class TextfieldSearchMenu extends StatelessWidget {
  const TextfieldSearchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return SizedBox(
      width: double.infinity,
      child: SearchTextField(
        controller: controller.searchMenuInPOS,
        onChanged: (value) => controller.orderBySearch(),
        hintText: "Cari menu..",
      ),
    );
  }
}
