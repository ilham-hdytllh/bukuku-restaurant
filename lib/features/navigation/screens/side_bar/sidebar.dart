import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/navigation/icon_navigation.dart';
import 'package:restaurant_bukuku/features/navigation/controllers/sidebar/sidebar_controller.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SidebarController());
    return SizedBox(
      width: 108,
      child: Scrollbar(
        controller: controller.scrollController,
        thumbVisibility: false,
        trackVisibility: false,
        thickness: 4,
        interactive: true,
        child: Obx(
          () {
            if (controller.isLoading.value == true) {
              return const SizedBox();
            }
            return ListView(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              children: [
                GestureDetector(
                  onTap: () => controller.updatePage(0),
                  child: NavigationIcon(
                    label: 'New Order',
                    icon: Iconsax.add_square,
                    selected: controller.index.value == 0,
                    visibility: controller.permission["create_order"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(1),
                  child: NavigationIcon(
                    label: 'Order',
                    icon: Iconsax.clipboard_text,
                    selected: controller.index.value == 1,
                    visibility: controller.permission["order"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(2),
                  child: NavigationIcon(
                    label: 'Menu',
                    icon: Iconsax.book_saved,
                    selected: controller.index.value == 2,
                    visibility: controller.permission["menu"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(3),
                  child: NavigationIcon(
                    label: 'Promotion',
                    icon: Iconsax.percentage_square,
                    selected: controller.index.value == 3,
                    visibility: controller.permission["promotion"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(4),
                  child: NavigationIcon(
                    label: 'Staff',
                    icon: Iconsax.personalcard,
                    selected: controller.index.value == 4,
                    visibility: controller.permission["staff"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(5),
                  child: NavigationIcon(
                    label: 'Inventory',
                    icon: Iconsax.box,
                    selected: controller.index.value == 5,
                    visibility: controller.permission["inventory"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(6),
                  child: NavigationIcon(
                    label: 'Branch',
                    icon: Iconsax.shop,
                    selected: controller.index.value == 6,
                    visibility: controller.permission["branch"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(7),
                  child: NavigationIcon(
                    label: 'Report',
                    icon: Iconsax.document_text,
                    selected: controller.index.value == 7,
                    visibility: controller.permission["report"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(8),
                  child: NavigationIcon(
                    label: 'Customer',
                    icon: Iconsax.user_octagon,
                    selected: controller.index.value == 8,
                    visibility: controller.permission["customer"],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.updatePage(9),
                  child: NavigationIcon(
                    label: 'Table',
                    icon: Icons.table_restaurant_rounded,
                    selected: controller.index.value == 9,
                    visibility: controller.permission["table"],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
