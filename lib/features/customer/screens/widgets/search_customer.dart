import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/customer/controllers/customer_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SearchCustomer extends StatelessWidget {
  const SearchCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final customerController = Get.put(CustomerController());
    return SizedBox(
        width: THelperFunctions.screenWidth() * 0.4,
        child: SearchTextField(
            onChanged: (value) => customerController.orderBySearch(),
            controller: customerController.searchCustomer.value,
            hintText: "Cari customer.."));
  }
}
