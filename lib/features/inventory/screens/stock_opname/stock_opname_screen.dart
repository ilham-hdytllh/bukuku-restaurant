import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class StockOpnameScreen extends StatelessWidget {
  const StockOpnameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        width: double.infinity,
        height: double.infinity,
        color: TColors.softGrey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () => Get.back(id: 5),
                      icon: const Icon(
                        Iconsax.arrow_left_copy,
                        size: 28,
                        color: TColors.primary,
                      )),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields - 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // search sku
                    SizedBox(
                        width: THelperFunctions.screenWidth() * 0.4,
                        child: SearchTextField(hintText: "Cari inventory..")),
                    const Spacer(),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
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
                      DataColumn(
                        label: Text(
                          'name'.tr,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'stockBefore'.tr,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'stockCurrent'.tr,
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
                    text: "dataNotFound".tr,
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          height: TSizes.inputFieldHeight,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("save".tr),
          ),
        ),
      ),
    );
  }
}
