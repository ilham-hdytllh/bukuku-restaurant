import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class ChooseTableOrderByGroupDialog extends StatelessWidget {
  const ChooseTableOrderByGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final createOrderController = Get.put(CreateOrderController());
    return Obx(
      () => Scrollbar(
        thumbVisibility: false,
        trackVisibility: false,
        thickness: 8,
        interactive: true,
        radius: const Radius.circular(5),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: createOrderController.allTablebySelectedGroup.length,
          itemBuilder: (context, index) {
            return Obx(
              () => RadioListTile(
                contentPadding: const EdgeInsets.only(right: 5, left: 5),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      createOrderController
                          .allTablebySelectedGroup[index].tableName
                          .capitalizeAll(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                value: createOrderController
                    .allTablebySelectedGroup[index].tableID,
                groupValue: createOrderController.selectedTableID.value,
                activeColor: TColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) => createOrderController.selectedTable(
                  createOrderController.allTablebySelectedGroup[index].tableID,
                  createOrderController
                      .allTablebySelectedGroup[index].tableName,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
