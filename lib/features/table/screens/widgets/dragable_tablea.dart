import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class GestureTable extends StatelessWidget {
  const GestureTable({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableController>(builder: (controller) {
      return Stack(
        fit: StackFit.expand,
        children: controller.allLayoutTableForView
            .map(
              (e) => Positioned(
                  left: e.offsetDx,
                  top: e.offsetDy,
                  child: Obx(
                    () => GestureDetector(
                        onScaleStart: controller.editLayout.value == true
                            ? (details) => controller.handleScaleStart(details)
                            : (details) {},
                        onScaleUpdate: controller.editLayout.value == true
                            ? (details) => controller.handleScaleUpdate(details,
                                controller.allLayoutTableForView.indexOf(e))
                            : (details) {},
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            controller.component(
                                e.componentID, e.tableName, e.maxQty),
                            controller.editLayout.value == true
                                ? Positioned(
                                    top: -10,
                                    right: -8,
                                    child: GestureDetector(
                                      onTap: () => controller.removeObject(
                                          controller.allLayoutTableForView
                                              .indexOf(e),
                                          e.tableID),
                                      child: const Icon(
                                        Iconsax.trash,
                                        size: TSizes.iconLg,
                                        color: TColors.error,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        )),
                  )),
            )
            .toList(),
      );
    });
  }
}
