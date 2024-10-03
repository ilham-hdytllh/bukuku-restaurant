import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SearchGroupTable extends StatelessWidget {
  const SearchGroupTable({super.key});

  @override
  Widget build(BuildContext context) {
    final tableController = Get.put(TableController());
    return SizedBox(
      width: THelperFunctions.screenWidth() * 0.4,
      child: SearchTextField(
        controller: tableController.searchGroupTable,
        onChanged: (value) => tableController.orderBySearch(),
        hintText: "Cari group..",
      ),
    );
  }
}
