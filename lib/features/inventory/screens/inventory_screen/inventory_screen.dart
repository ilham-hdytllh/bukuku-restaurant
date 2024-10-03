import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/inventory/screens/stock_opname/stock_opname_screen.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                  // search sku
                  SizedBox(
                      width: THelperFunctions.screenWidth() * 0.4,
                      child: SearchTextField(
                          hintText: "searchInventoryHintText".tr)),
                  const Spacer(),

                  // button add stock
                  SizedBox(
                    height: TSizes.inputFieldHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.add_copy,
                        size: 18,
                        color: TColors.white,
                      ),
                      label: Text("addInventoryButton".tr),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  // stock opname button
                  SizedBox(
                    height: TSizes.inputFieldHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.black),
                      onPressed: () => Get.to(const StockOpnameScreen(), id: 5),
                      child: Text("stockOpnameButton".tr),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  dividerThickness: 0.5,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: TColors.grey),
                      color: TColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  headingTextStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: TColors.black),
                  dataTextStyle:
                      Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: TColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                  headingRowHeight: 50,
                  dataRowMaxHeight: 50,
                  dataRowMinHeight: 50,
                  columnSpacing: 5,
                  columns: [
                    const DataColumn(
                      label: Text(
                        'No',
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        'SKU',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'name'.tr,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'stock'.tr,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'unit'.tr,
                      ),
                    ),
                  ],
                  rows: [],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: TColors.grey),
                    color: TColors.white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                height: 250,
                child: EmptyItem(
                  text: "inventoryNotFound".tr,
                  fit: BoxFit.fitWidth,
                  picture: const Icon(
                    Iconsax.box_1_copy,
                    color: TColors.darkGrey,
                    size: TSizes.iconXL,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
