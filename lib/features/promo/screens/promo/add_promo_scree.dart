import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/custom_back_button/custom_back_button.dart';
import 'package:restaurant_bukuku/features/promo/controllers/promo_controller.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/add_general_promo_form.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/add_product_promo_form.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/promotion_card_filter.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class AddPromoScreen extends StatelessWidget {
  const AddPromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final promoController = Get.put(PromoController());
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: TSizes.spaceBtwText,
                  ),
                  CustomBackButton(
                    onTap: () => Get.back(id: 3),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwText,
                  ),
                  Expanded(
                    child: Obx(
                      () => GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2 / 1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          crossAxisCount: 2,
                        ),
                        children: [
                          GestureDetector(
                            onTap: () => promoController
                                .selectedPromoType.value = "general",
                            child: PromotionCardFilter(
                                title: "General Promo",
                                subTitle: "Applied to all menu in your shop",
                                selected:
                                    promoController.selectedPromoType.value ==
                                        "general"),
                          ),
                          GestureDetector(
                            onTap: () => promoController
                                .selectedPromoType.value = "product",
                            child: PromotionCardFilter(
                                title: "Selected Products Promo",
                                subTitle:
                                    "Configure promo for selected menu or category in your shop",
                                selected:
                                    promoController.selectedPromoType.value ==
                                        "product"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // form
          Obx(() => promoController.selectedPromoType.value == "general"
              ? const AddGeneralPromoForm()
              : const AddProductPromoForm()),
        ],
      ),
    );
  }
}
