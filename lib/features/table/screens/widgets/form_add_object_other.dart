import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_11.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_12.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_13.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_14.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_15.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_16.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class FormAddObject extends StatelessWidget {
  const FormAddObject({super.key});

  @override
  Widget build(BuildContext context) {
    final tableController = Get.put(TableController());
    return Form(
      key: tableController.tableGroupFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            RichText(
                text: TextSpan(
                    text: "Object Name",
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
              controller: tableController.tableName,
              validator: (value) =>
                  TValidator.validateEmptyText("Object name", value),
              decoration: const InputDecoration(hintText: "Ex: Toilet"),
              style: const TextStyle()
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
              onTapOutside: (value) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            RichText(
                text: TextSpan(
                    text: "Object Shape",
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
            SizedBox(
              width: double.infinity,
              height: 130,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: tableController.dataComponent.length,
                  itemBuilder: (context, index) => tableController
                              .dataComponent[index] ==
                          "component11"
                      ? Obx(
                          () => GestureDetector(
                            onTap: () {
                              tableController.selectedComponent.value =
                                  tableController.dataComponent[index];
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: tableController
                                                .selectedComponent.value ==
                                            tableController.dataComponent[index]
                                        ? TColors.primary
                                        : TColors.darkGrey),
                              ),
                              // ganti custom table
                              child: const Component11(
                                tableName: "",
                              ),
                            ),
                          ),
                        )
                      : tableController.dataComponent[index] == "component12"
                          ? Obx(
                              () => GestureDetector(
                                onTap: () {
                                  tableController.selectedComponent.value =
                                      tableController.dataComponent[index];
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: tableController
                                                    .selectedComponent.value ==
                                                tableController
                                                    .dataComponent[index]
                                            ? TColors.primary
                                            : TColors.darkGrey),
                                  ),
                                  // ganti custom table
                                  child: const Component12(
                                    tableName: "",
                                  ),
                                ),
                              ),
                            )
                          : tableController.dataComponent[index] ==
                                  "component13"
                              ? Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      tableController.selectedComponent.value =
                                          tableController.dataComponent[index];
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: tableController
                                                        .selectedComponent
                                                        .value ==
                                                    tableController
                                                        .dataComponent[index]
                                                ? TColors.primary
                                                : TColors.darkGrey),
                                      ),
                                      // ganti custom table
                                      child: const Component13(
                                        tableName: "",
                                      ),
                                    ),
                                  ),
                                )
                              : tableController.dataComponent[index] ==
                                      "component14"
                                  ? Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          tableController
                                                  .selectedComponent.value =
                                              tableController
                                                  .dataComponent[index];
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: tableController
                                                            .selectedComponent
                                                            .value ==
                                                        tableController
                                                                .dataComponent[
                                                            index]
                                                    ? TColors.primary
                                                    : TColors.darkGrey),
                                          ),
                                          // ganti custom table
                                          child: const Component14(
                                            tableName: "",
                                          ),
                                        ),
                                      ),
                                    )
                                  : tableController.dataComponent[index] ==
                                          "component15"
                                      ? Obx(
                                          () => GestureDetector(
                                            onTap: () {
                                              tableController
                                                      .selectedComponent.value =
                                                  tableController
                                                      .dataComponent[index];
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: tableController
                                                                .selectedComponent
                                                                .value ==
                                                            tableController
                                                                    .dataComponent[
                                                                index]
                                                        ? TColors.primary
                                                        : TColors.darkGrey),
                                              ),
                                              // ganti custom table
                                              child: const Component15(
                                                tableName: "",
                                              ),
                                            ),
                                          ),
                                        )
                                      : tableController.dataComponent[index] ==
                                              "component16"
                                          ? Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  tableController
                                                          .selectedComponent
                                                          .value =
                                                      tableController
                                                          .dataComponent[index];
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: tableController
                                                                    .selectedComponent
                                                                    .value ==
                                                                tableController
                                                                        .dataComponent[
                                                                    index]
                                                            ? TColors.primary
                                                            : TColors.darkGrey),
                                                  ),
                                                  // ganti custom table
                                                  child: const Component16(
                                                    tableName: "",
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()),
            ),
          ],
        ),
      ),
    );
  }
}
