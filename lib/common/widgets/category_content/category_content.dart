import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/category_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class CategoryContent extends StatelessWidget {
  final RxString? text;
  final TextEditingController? controller;
  final Function? onChanged;
  const CategoryContent(
      {super.key, this.controller, this.text, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(
      () => Scrollbar(
        thumbVisibility: false,
        trackVisibility: false,
        thickness: 8,
        interactive: true,
        radius: const Radius.circular(5),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.allCategory.length,
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
                      categoryController.allCategory[index].categoryName
                          .capitalizeAll(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                value: categoryController.allCategory[index].categoryName,
                groupValue: (text != null) ? text!.value : controller!.text,
                activeColor: TColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  if (text != null) {
                    text!.value =
                        categoryController.allCategory[index].categoryName;
                    onChanged!();
                  } else {
                    controller!.text =
                        categoryController.allCategory[index].categoryName;
                  }

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
