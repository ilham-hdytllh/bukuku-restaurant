import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.width, required this.active});
  final double width;
  final RxBool active;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => active.value = !active.value,
        child: Container(
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34), color: TColors.black),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: active.value ? Colors.white : TColors.black),
                  child: Center(
                      child: Text(
                    'Active',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: active.value ? Colors.black : Colors.white),
                  )),
                ),
                Container(
                  width: 60,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: active.value ? TColors.black : Colors.white),
                  child: Center(
                      child: Text(
                    'Inactive',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: active.value ? Colors.white : Colors.black),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
