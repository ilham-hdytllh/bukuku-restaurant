import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/text_field/search_textfield.dart';
import 'package:restaurant_bukuku/features/branch/controllers/branch_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SearchBranch extends StatelessWidget {
  const SearchBranch({super.key});

  @override
  Widget build(BuildContext context) {
    final branchController = Get.put(BranchController());
    return SizedBox(
        width: THelperFunctions.screenWidth() * 0.4,
        child: Obx(
          () => SearchTextField(
              onChanged: (value) => branchController.orderBySearch(),
              controller: branchController.searchBranch.value,
              hintText: "searchBranchHintText".tr),
        ));
  }
}
