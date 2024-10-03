import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/customer/controllers/customer_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/location_dropdown/district_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class ContentGetDistrict extends StatelessWidget {
  const ContentGetDistrict({super.key});

  @override
  Widget build(BuildContext context) {
    final DistrictController districtController = Get.put(DistrictController());
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
          itemCount: districtController.districtData.length,
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
                      districtController.districtData[index]["nama"]
                          .toString()
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                value: districtController.districtData[index]["nama"]
                    .toString()
                    .toUpperCase(),
                groupValue: customerController.province.value.text,
                activeColor: TColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  // memasukan nama provinsi kedalam customer controller
                  customerController.district.value.text = districtController
                      .districtData[index]["nama"]
                      .toString()
                      .toUpperCase();
                  // memasukan id provinsi kedalam provinsi controller
                  districtController.selectedDistrictId.value =
                      districtController.districtData[index]["id"];
                  // hapus isi jika mengganti provinsi
                  customerController.postalCode.value.clear();
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
