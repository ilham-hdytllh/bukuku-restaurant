import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class CustomTextfieldCustomer extends StatelessWidget {
  const CustomTextfieldCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final createOrderController = Get.put(CreateOrderController());
    return Flexible(
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: const TextStyle()
            .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
        onTapOutside: (value) => FocusScope.of(context).unfocus(),
        controller: createOrderController.customerName,
        decoration: InputDecoration(
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: TColors.darkGrey),
          hintText: "Customer name..",
          suffixIcon: Container(
            width: 50,
            decoration: const BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: const Center(
              child: Icon(
                Iconsax.user_copy,
                color: TColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
