import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/category_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Form(
      key: categoryController.categoryFormkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          RichText(
              text: TextSpan(
                  text: "Name",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                TextSpan(
                    text: ' *',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: TColors.primary))
              ])),
          const SizedBox(
            height: TSizes.spaceBtwInputFields - 8,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: categoryController.categoryName,
            validator: (value) => TValidator.validateEmptyText("Name", value),
            decoration: const InputDecoration(hintText: "Ex: Food"),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
