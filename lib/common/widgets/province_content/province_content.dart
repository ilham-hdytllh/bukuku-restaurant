import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/customer/controllers/customer_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/location_dropdown/province_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class ContentGetProvince extends StatelessWidget {
  const ContentGetProvince({super.key});

  @override
  Widget build(BuildContext context) {
    final ProvinceController provinceController = Get.put(ProvinceController());
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
          itemCount: provinceController.provinceData.length,
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
                      "${provinceController.provinceData[index]["nama"]}",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                value: provinceController.provinceData[index]["nama"],
                groupValue: customerController.province.value.text,
                activeColor: TColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  // memasukan nama provinsi kedalam customer controller
                  customerController.province.value.text =
                      provinceController.provinceData[index]["nama"];
                  // memasukan id provinsi kedalam provinsi controller
                  provinceController.selectedProvinceId.value =
                      provinceController.provinceData[index]["id"];
                  // hapus isi jika mengganti provinsi
                  customerController.city.value.clear();
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
