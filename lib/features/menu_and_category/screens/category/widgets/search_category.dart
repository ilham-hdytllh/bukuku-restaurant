import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/category_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SearchCategory extends StatelessWidget {
  const SearchCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return SizedBox(
      width: THelperFunctions.screenWidth() * 0.4,
      child: SearchTextField(
        controller: categoryController.searchCategory,
        onChanged: (value) => categoryController.orderBySearch(),
        hintText: "Cari category..",
      ),
    );
  }
}
