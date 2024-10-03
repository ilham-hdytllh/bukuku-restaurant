import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/sales_type.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class PickSalesType extends StatelessWidget {
  const PickSalesType({super.key});

  @override
  Widget build(BuildContext context) {
    final createOrderController = Get.put(CreateOrderController());
    return Flexible(
      child: Obx(
        () => TextFormField(
          readOnly: true,
          keyboardType: TextInputType.none,
          onTap: () => CustomDialog.tabletDialog(
              THelperFunctions.screenWidth() * 0.5,
              () {},
              "",
              "Pilih Tipe Penjualan",
              const SalesType(),
              false),
          style: const TextStyle()
              .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
          onTapOutside: (value) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: createOrderController.selectedSalesType.value,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: TColors.black),
            prefixIcon: const Icon(
              Iconsax.reserve_copy,
              color: TColors.darkGrey,
            ),
            suffixIcon: const Icon(
              Iconsax.arrow_down_1_copy,
              color: TColors.darkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
