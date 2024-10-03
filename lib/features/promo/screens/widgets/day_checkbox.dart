import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/promo/controllers/promo_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class DaysCheckbox extends StatelessWidget {
  const DaysCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final promoController = Get.put(PromoController());
    return Obx(
      () => promoController.promotionActiveType.value == "days"
          ? ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: promoController.daysOfWeek.length,
              itemBuilder: (context, index) => Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: TColors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(
                      () => CheckboxListTile(
                        contentPadding: const EdgeInsets.only(left: 15),
                        title: Text(
                          promoController.daysOfWeek[index],
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: promoController.selectedDays.contains(index),
                        onChanged: (value) => promoController.addDay(index),
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  color: TColors.grey,
                );
              },
            )
          : const SizedBox(),
    );
  }
}
