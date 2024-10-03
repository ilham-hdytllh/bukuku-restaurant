import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/remove_alert_content/remove_alert_content.dart';
import 'package:restaurant_bukuku/features/promo/controllers/promo_controller.dart';
import 'package:restaurant_bukuku/features/promo/screens/promo/add_promo_scree.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/update_general_promo.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/update_product_promo.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final promoController = Get.put(PromoController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: double.infinity,
      color: TColors.softGrey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwInputFields - 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: TSizes.inputFieldHeight,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.black,
                          side: const BorderSide(color: TColors.black)),
                      icon: const Icon(
                        Iconsax.setting_4_copy,
                        size: 20,
                        color: TColors.white,
                      ),
                      label: Text(
                        "Semua Promo",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: TColors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: TSizes.inputFieldHeight,
                    width: 120,
                    child: ElevatedButton.icon(
                      onPressed: () => Get.to(const AddPromoScreen(),
                          id: 3,
                          duration: const Duration(milliseconds: 500),
                          transition: Transition.fade),
                      icon: const Icon(
                        Iconsax.add_copy,
                        size: TSizes.iconSm,
                        color: TColors.white,
                      ),
                      label: const Text("Promo"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return DataTable(
                    columns: promoController.promoTableLabel
                        .map((data) => DataColumn(
                              label: Text(
                                data,
                              ),
                            ))
                        .toList(),
                    rows: promoController.allPromoToView.map((element) {
                      return DataRow(cells: [
                        DataCell(
                          Text(
                            (promoController.allPromoToView.indexOf(element) +
                                    1)
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            element.promoName.capitalizeAll(),
                          ),
                        ),
                        DataCell(
                          Text(
                            element.promoType.capitalizeAll(),
                          ),
                        ),
                        DataCell(
                          Text(
                            element.promotionActiveType.capitalizeAll(),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (element.promoType == "general") {
                                    promoController.initDataUpdate(
                                        branchID: element.branchID,
                                        promoID: element.promoID,
                                        promoType: element.promoType,
                                        discountType: element.discountType,
                                        promoName: element.promoName,
                                        promoDescription:
                                            element.promoDescription,
                                        maximumDiscount:
                                            element.maximumDiscount,
                                        discountPercent:
                                            element.discountPercent,
                                        discountAmount: element.discountAmount,
                                        minimumPurchase:
                                            element.minimumPurchase,
                                        dataPromotionActiveType:
                                            element.promotionActiveType,
                                        startDate: element.startDate,
                                        endDate: element.endDate,
                                        dataActiveDays: element.activeDays,
                                        promotionHour: element.promotionHour,
                                        startHour: element.startHour,
                                        endHour: element.endHour,
                                        menuPromotions: element.menuPromotions,
                                        categoryPromotions:
                                            element.categoryPromotions,
                                        qtyMultiplePurchase:
                                            element.qtyMultiplePurchase);
                                    Get.to(const UpdateGeneralPromoForm(),
                                        id: 3,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        transition: Transition.fade);
                                  } else {
                                    Get.to(const UpdateProductPromoForm(),
                                        id: 3,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        transition: Transition.fade);
                                  }
                                },
                                child: Text(
                                  'edit'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: TColors.primary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              const VerticalDivider(
                                indent: 10,
                                endIndent: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  CustomDialog.confirmationDialog(
                                      (THelperFunctions.screenWidth() * 0.45),
                                      () => promoController
                                          .deletePromoRecord(element.promoID),
                                      "delete".tr,
                                      "confirmation".tr,
                                      const RemoveAlertContent(
                                        title:
                                            "Yakin ingin menghapus promo ini ?",
                                        subTitle:
                                            "Promo yang telah di hapus tidak dapat di kembalikan..",
                                      ),
                                      Iconsax.trash_copy,
                                      TColors.error,
                                      promoController.isLoadingDelete.value);
                                },
                                child: Text(
                                  'delete'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: TColors.error,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
                    }).toList(),
                  );
                }),
              ),
              Obx(
                () {
                  return promoController.allPromoToView.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: TColors.grey),
                              color: TColors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          height: 220,
                          child: EmptyItem(
                            text: "No Promo",
                            desciption: "No Promo in the list",
                            fit: BoxFit.fitWidth,
                            picture: Image.asset(
                              TImages.promoIcon,
                              height: 90,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
