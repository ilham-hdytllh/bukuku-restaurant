import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/promo/percent_or_amount.dart';
import 'package:restaurant_bukuku/common/widgets/promo/promo_menu.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class AddToCart extends GetView<CreateOrderController> {
  const AddToCart({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.allowFlexiblePrice,
  });
  final String image, name;
  final double price;
  final bool allowFlexiblePrice;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Text(
                    name.capitalizeAll(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwText,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: allowFlexiblePrice,
                      keyboardType: TextInputType.number,
                      controller: controller.price,
                      style: const TextStyle().copyWith(
                          fontSize: 14.0, fontWeight: FontWeight.normal),
                      onTapOutside: (value) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder().copyWith(
                          borderRadius:
                              BorderRadius.circular(TSizes.inputFieldRadius),
                          borderSide:
                              const BorderSide(width: 1, color: TColors.grey),
                        ),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 60,
                          decoration: const BoxDecoration(
                              color: TColors.grey,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))),
                          child: const Center(
                            child: Text(
                              "Rp",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            readOnly: true,
            keyboardType: TextInputType.none,
            onTap: () => CustomDialog.tabletDialog(
                THelperFunctions.screenWidth() * 0.5,
                () {},
                "",
                "Pilih Promo",
                const PromoMenuInDialog(),
                false),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              hintText: "Pilih Promo",
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: TColors.darkGrey),
              prefixIcon: const Icon(
                Iconsax.percentage_square,
                color: TColors.primary,
              ),
              suffixIcon: const Icon(
                Iconsax.arrow_down_1_copy,
                color: TColors.darkGrey,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Diskon",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: TSizes.defaultSpace - 15,
                    ),
                    Obx(() {
                      return controller.discountType.value == "rp"
                          ? TextFormField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle().copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                              onTapOutside: (value) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                prefixIcon: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 60,
                                  decoration: const BoxDecoration(
                                      color: TColors.grey,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5))),
                                  child: const Center(
                                    child: Text(
                                      "Rp",
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : TextFormField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle().copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                              onTapOutside: (value) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: 60,
                                  decoration: const BoxDecoration(
                                      color: TColors.grey,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: const Center(
                                    child: Text(
                                      "%",
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Flexible(
                flex: 1,
                child: Obx(
                  () => TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    onTap: () => CustomDialog.tabletDialog(
                        THelperFunctions.screenWidth() * 0.4,
                        () {},
                        "",
                        "Pilih Tipe Diskon",
                        const PercentOrAmount(),
                        false),
                    style: const TextStyle().copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      hintText: controller.discountType.value.capitalize,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w400),
                      suffixIcon: const Icon(
                        Iconsax.arrow_down_1_copy,
                        color: TColors.darkGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Text(
            "Catatan (Opsional)",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: TSizes.defaultSpace - 15,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            maxLines: 4,
            minLines: 4,
            controller: controller.note,
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10, left: 10),
              hintText: "Cth : Jangan pakai bawang goreng ya.",
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: TColors.darkGrey, fontSize: 14),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 35,
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.quantityItem.value < 2) {
                          null;
                        } else {
                          controller.quantityItem.value--;
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.quantityItem < 2
                              ? Colors.transparent
                              : TColors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1,
                              color: controller.quantityItem < 2
                                  ? Colors.transparent
                                  : TColors.black),
                        ),
                        width: 35,
                        height: 35,
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: controller.quantityItem < 2
                              ? TColors.black
                              : TColors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Center(
                        child: Text(
                          controller.quantityItem.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.quantityItem.value++,
                      child: Container(
                        decoration: BoxDecoration(
                          color: TColors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: TColors.black),
                        ),
                        width: 35,
                        height: 35,
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: TColors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
        ],
      ),
    );
  }
}
