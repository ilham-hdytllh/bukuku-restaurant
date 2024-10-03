import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/branch/screens/branch_screen.dart';
import 'package:restaurant_bukuku/features/create_order/screens/menu_order/menu_order.dart';
import 'package:restaurant_bukuku/features/customer/screens/customer_screens.dart';
import 'package:restaurant_bukuku/features/employe/screens/employe/employe_screen.dart';
import 'package:restaurant_bukuku/features/inventory/screens/inventory_screen/inventory_screen.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/menu_screens.dart';
import 'package:restaurant_bukuku/features/navigation/controllers/sidebar/sidebar_controller.dart';
import 'package:restaurant_bukuku/features/navigation/screens/app_bar/custom_appbar.dart';
import 'package:restaurant_bukuku/features/navigation/screens/side_bar/sidebar.dart';
import 'package:restaurant_bukuku/features/order/screens/list_order/list_order.dart';
import 'package:restaurant_bukuku/features/promo/screens/promo/promo_screens.dart';
import 'package:restaurant_bukuku/features/table/screens/table_screen.dart';
import 'package:restaurant_bukuku/utils/divider/vertical_divider.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SidebarController());

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          children: [
            // Custom Sidebar
            const CustomSidebar(),
            const CustomVerticalDivider(),
            Expanded(
              child: Column(
                children: [
                  // Custom Appbar
                  const CustomAppbar(),
                  Expanded(
                    child: Obx(
                      () => IndexedStack(
                        index: controller.index.value,
                        children: [
                          _wrapWithNavigator(const MenuOrderPage(), 0),
                          _wrapWithNavigator(const ListOrderScreen(), 1),
                          _wrapWithNavigator(const MenuScreens(), 2),
                          _wrapWithNavigator(const PromoScreen(), 3),
                          _wrapWithNavigator(const EmployeScreen(), 4),
                          _wrapWithNavigator(const InventoryScreen(), 5),
                          _wrapWithNavigator(const BranchScreen(), 6),
                          const SizedBox(),
                          _wrapWithNavigator(const CustomerScreen(), 8),
                          _wrapWithNavigator(const TableScreen(), 9),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // set nested key navigator to spesific index
  Widget _wrapWithNavigator(Widget child, int index) {
    return Navigator(
      key: Get.nestedKey(index),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
