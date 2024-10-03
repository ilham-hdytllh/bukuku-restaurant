import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/features/create_order/models/cart_model.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/menu_model.dart';
import 'package:restaurant_bukuku/features/payment/screens/cekout_screen.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final cartLength = 0.obs;
  final totalCartPrice = 0.0.obs;
  final cartItem = <CartModel>[].obs;
  final dateAndTime = "".obs;

  void addItemToCart(MenuModel menuModel) {
    final createOrderController = Get.put(CreateOrderController());
    final selectedCartItem = convertToCartItem(menuModel);
    cartItem.add(selectedCartItem);

    createOrderController.note.clear();
    createOrderController.price.clear();
    createOrderController.quantityItem.value = 1;

    updateTotalPriceCart();
    Get.back();
  }

  void removeItemInCart(int index) {
    cartItem.removeAt(index);
    updateTotalPriceCart();
  }

  void incrementQtyInCart(int index) {
    cartItem[index].quantity++;
    updateTotalPriceCart();
  }

  void decrementQtyInCart(int index) {
    if (cartItem[index].quantity > 1) {
      cartItem[index].quantity--;
      updateTotalPriceCart();
    }
  }

  void updateTotalPriceCart() {
    double totalPrice = 0.0;

    for (var item in cartItem) {
      totalPrice += (item.price * item.quantity);
    }

    totalCartPrice.value = totalPrice;
    cartLength.value = cartItem.length;
  }

  CartModel convertToCartItem(MenuModel menuModel) {
    final createOrderController = Get.put(CreateOrderController());
    return CartModel(
      menuID: menuModel.menuID,
      menuName: menuModel.menuName,
      image: menuModel.menuImage,
      note: createOrderController.note.text,
      price: double.tryParse(createOrderController.price.text) ?? 0.0,
      quantity: createOrderController.quantityItem.value,
    );
  }

  void navigateToCekoutOrder() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMM yyyy HH:mm').format(now);
    dateAndTime.value = formattedDate;
    Get.to(const CekoutScreen(),
        id: 0,
        duration: const Duration(milliseconds: 500),
        transition: Transition.fade);
  }
}
