import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/customer/controllers/customer_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/location_dropdown/city_controller.dart';

import 'package:restaurant_bukuku/utils/constants/colors.dart';

class ContentGetCity extends StatelessWidget {
  const ContentGetCity({super.key});

  @override
  Widget build(BuildContext context) {
    final CityController cityController = Get.put(CityController());
    final CustomerController customerController = Get.put(CustomerController());
    return Obx(
      () => Scrollbar(
        thumbVisibility: false,
        trackVisibility: false,
        thickness: 8,
        interactive: true,
        radius: const Radius.circular(5),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cityController.cityData.length,
          itemBuilder: (context, index) {
            return Obx(
              () => RadioListTile(
                contentPadding: const EdgeInsets.only(right: 5, left: 5),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${cityController.cityData[index]["nama"]}",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                value: cityController.cityData[index]["nama"],
                groupValue: customerController.province.value.text,
                activeColor: TColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  // memasukkan nama kota ke dalam customer controller
                  customerController.city.value.text =
                      cityController.cityData[index]["nama"];
                  // memasukkan id kota kedalam citycontroller
                  cityController.selectedCityId.value =
                      cityController.cityData[index]["id"];
                  // menghapus district jika mengganti kota
                  customerController.district.value.clear();
                  Get.back();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
