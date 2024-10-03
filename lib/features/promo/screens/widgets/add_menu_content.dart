import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/features/promo/controllers/promo_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';

class GetMenuContent extends StatelessWidget {
  const GetMenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    final promoController = Get.put(PromoController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: TSizes.inputFieldHeight,
            child: Obx(
              () => TextFormField(
                onChanged: (value) => promoController.filterNameDataMenu(),
                controller: promoController.searchMenu.value,
                decoration: InputDecoration(
                  border: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(TSizes.inputFieldRadius),
                    borderSide:
                        const BorderSide(width: 1, color: TColors.darkGrey),
                  ),
                  enabledBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(TSizes.inputFieldRadius),
                    borderSide:
                        const BorderSide(width: 1, color: TColors.darkGrey),
                  ),
                  focusedBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(TSizes.inputFieldRadius),
                    borderSide:
                        const BorderSide(width: 1, color: TColors.primary),
                  ),
                ),
                style: const TextStyle()
                    .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                onTapOutside: (value) => FocusScope.of(context).unfocus(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            if (promoController.isLoadingGet.value == true) {
              return TLoader.customCircularProgress();
            } else if (promoController
                .allMenuInNotselectedMenuForPromo.isEmpty) {
              return EmptyItem(
                text: "No Menu",
                desciption: "No menu in the list",
                fit: BoxFit.fitWidth,
                picture: Image.asset(
                  TImages.foodIcon,
                  height: 90,
                  fit: BoxFit.fitHeight,
                ),
              );
            } else {
              return Scrollbar(
                thumbVisibility: false,
                trackVisibility: false,
                thickness: 8,
                interactive: true,
                radius: const Radius.circular(5),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        promoController.allMenuInNotselectedMenuForPromo.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => ListTile(
                          onTap: () => promoController.addToSelectedMenu(
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .menuID,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .merchantID,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .branchID,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .menuName,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .menuImage,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .description,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .category,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .allowFlexiblePrice,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .price,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .recipes,
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .addons),
                          contentPadding:
                              const EdgeInsets.only(right: 5, left: 5),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              promoController
                                  .allMenuInNotselectedMenuForPromo[index]
                                  .menuImage,
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            promoController
                                .allMenuInNotselectedMenuForPromo[index]
                                .menuName
                                .capitalizeAll(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Text(
                            "Rp ${promoController.allMenuInNotselectedMenuForPromo[index].price.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: TColors.primary),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
