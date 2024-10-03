import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/employe/controller/roles/roles_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class PermissionCheckbox extends StatelessWidget {
  const PermissionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final roleController = Get.put(RoleController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: "Permission Setting",
              style: Theme.of(context).textTheme.titleLarge,
              children: [
                TextSpan(
                  text: ' *',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: TColors.primary),
                )
              ],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields - 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Branch",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["branch"],
                        onChanged: (values) {
                          roleController.permissionSelected["branch"] = values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Create Order",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value:
                            roleController.permissionSelected["create_order"],
                        onChanged: (values) {
                          roleController.permissionSelected["create_order"] =
                              values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Customer",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["customer"],
                        onChanged: (values) {
                          roleController.permissionSelected["customer"] =
                              values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Inventory",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["inventory"],
                        onChanged: (values) {
                          roleController.permissionSelected["inventory"] =
                              values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Menu",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["menu"],
                        onChanged: (values) {
                          roleController.permissionSelected["menu"] = values!;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Order",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["order"],
                        onChanged: (values) {
                          roleController.permissionSelected["order"] = values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Promotion",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["promotion"],
                        onChanged: (values) {
                          roleController.permissionSelected["promotion"] =
                              values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Report",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["report"],
                        onChanged: (values) {
                          roleController.permissionSelected["report"] = values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Staff",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["staff"],
                        onChanged: (values) {
                          roleController.permissionSelected["staff"] = values!;
                        },
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        side:
                            const BorderSide(width: 1, color: TColors.primary),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Table",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        value: roleController.permissionSelected["table"],
                        onChanged: (values) {
                          roleController.permissionSelected["table"] = values!;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
