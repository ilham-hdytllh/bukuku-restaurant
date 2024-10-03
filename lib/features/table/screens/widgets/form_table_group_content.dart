import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/custom_switch/custom_switch.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class FormTableGroupContent extends StatelessWidget {
  const FormTableGroupContent({super.key});

  @override
  Widget build(BuildContext context) {
    final tableController = Get.put(TableController());
    return Form(
      key: tableController.tableGroupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          RichText(
              text: TextSpan(
                  text: "Group Name",
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
            controller: tableController.groupTableNameController,
            validator: (value) =>
                TValidator.validateEmptyText("Group name", value),
            decoration: const InputDecoration(hintText: "Ex: Floor One"),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          RichText(
              text: TextSpan(
                  text: "Status",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                TextSpan(
                    text: '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: TColors.primary))
              ])),
          const SizedBox(
            height: TSizes.spaceBtwInputFields - 8,
          ),
          CustomSwitch(width: 130, active: tableController.active),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
