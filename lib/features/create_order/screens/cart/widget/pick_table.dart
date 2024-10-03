import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/create_order/screens/cart/widget/choose_table.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class PickTable extends StatelessWidget {
  const PickTable({super.key});

  @override
  Widget build(BuildContext context) {
    final createOrderController = Get.put(CreateOrderController());
    return Flexible(
      child: TextFormField(
        readOnly: true,
        keyboardType: TextInputType.none,
        controller: createOrderController.tableAndGroupSelected,
        style: const TextStyle()
            .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
        onTapOutside: (value) => FocusScope.of(context).unfocus(),
        onTap: () {
          CustomDialog.tabletDialog(
            (THelperFunctions.screenWidth() * 0.5),
            () => createOrderController.setGroupAndTable(),
            "Select",
            "Select Table",
            const ChooseTableDialog(),
            true,
          );
        },
        decoration: InputDecoration(
          hintText: "Select Table",
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: TColors.darkGrey),
          prefixIcon: const Icon(
            Icons.table_bar,
            color: TColors.darkGrey,
          ),
          suffixIcon: const Icon(
            Iconsax.arrow_down_1_copy,
            color: TColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
