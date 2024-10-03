import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class SelectTableGroupDialog extends StatelessWidget {
  const SelectTableGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final tableController = Get.put(TableController());
    return Obx(
      () => Scrollbar(
        thumbVisibility: false,
        trackVisibility: false,
        thickness: 8,
        interactive: true,
        radius: const Radius.circular(5),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tableController.allGroupTableForView.length,
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
                      tableController.allGroupTableForView[index].groupName
                          .capitalizeAll(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                value: tableController.allGroupTableForView[index].groupID,
                groupValue: tableController.selectedGroupID.value,
                activeColor: TColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) => tableController.selectedGroupTable(
                    tableController.allGroupTableForView[index].groupID,
                    tableController.allGroupTableForView[index].groupName),
              ),
            );
          },
        ),
      ),
    );
  }
}
