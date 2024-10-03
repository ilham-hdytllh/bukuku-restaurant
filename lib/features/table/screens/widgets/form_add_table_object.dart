import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/table/controllers/table_controller.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_1.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_2.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_3.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_4.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_5.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_6.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_7.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/component_8.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class FormAddTableObject extends StatelessWidget {
  const FormAddTableObject({super.key});

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
                    text: "Table Name",
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
                  TValidator.validateEmptyText("Table name", value),
              decoration: const InputDecoration(hintText: "Ex: Table 1"),
              style: const TextStyle()
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
              onTapOutside: (value) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            RichText(
                text: TextSpan(
                    text: "Capacity",
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
            Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (tableController.capacity.value <= 1) {
                        null;
                      } else {
                        tableController.capacity.value--;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: TColors.grey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: TColors.grey),
                      ),
                      width: 35,
                      height: 35,
                      child: const Icon(
                        Icons.remove,
                        size: 20,
                        color: TColors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 90,
                    color: TColors.softGrey,
                    child: Center(
                      child: Text(
                        tableController.capacity.value.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      tableController.capacity.value++;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: TColors.grey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: TColors.grey),
                      ),
                      width: 35,
                      height: 35,
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: TColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            RichText(
                text: TextSpan(
                    text: "Table Shape",
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
                        "component1"
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
                            child: const Component1(
                              tableName: "",
                              tableQty: 0,
                            ),
                          ),
                        ),
                      )
                    : tableController.dataComponent[index] == "component2"
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
                                child: const Component2(
                                  tableName: "",
                                  tableQty: 0,
                                ),
                              ),
                            ),
                          )
                        : tableController.dataComponent[index] == "component3"
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
                                    child: const Component3(
                                      tableName: "",
                                      tableQty: 0,
                                    ),
                                  ),
                                ),
                              )
                            : tableController.dataComponent[index] ==
                                    "component4"
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
                                                          .dataComponent[index]
                                                  ? TColors.primary
                                                  : TColors.darkGrey),
                                        ),
                                        // ganti custom table
                                        child: const Component4(
                                          tableName: "",
                                          tableQty: 0,
                                        ),
                                      ),
                                    ),
                                  )
                                : tableController.dataComponent[index] ==
                                        "component5"
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
                                            child: const Component5(
                                              tableName: "",
                                              tableQty: 0,
                                            ),
                                          ),
                                        ),
                                      )
                                    : tableController.dataComponent[index] ==
                                            "component6"
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
                                                child: const Component6(
                                                  tableName: "",
                                                  tableQty: 0,
                                                ),
                                              ),
                                            ),
                                          )
                                        : tableController
                                                    .dataComponent[index] ==
                                                "component7"
                                            ? Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    tableController
                                                            .selectedComponent
                                                            .value =
                                                        tableController
                                                                .dataComponent[
                                                            index];
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
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
                                                              : TColors
                                                                  .darkGrey),
                                                    ),
                                                    // ganti custom table
                                                    child: const Component7(
                                                      tableName: "",
                                                      tableQty: 0,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : tableController
                                                        .dataComponent[index] ==
                                                    "component8"
                                                ? Obx(
                                                    () => GestureDetector(
                                                      onTap: () {
                                                        tableController
                                                            .selectedComponent
                                                            .value = tableController
                                                                .dataComponent[
                                                            index];
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: tableController
                                                                          .selectedComponent
                                                                          .value ==
                                                                      tableController
                                                                              .dataComponent[
                                                                          index]
                                                                  ? TColors
                                                                      .primary
                                                                  : TColors
                                                                      .darkGrey),
                                                        ),
                                                        // ganti custom table
                                                        child: const Component8(
                                                          tableName: "",
                                                          tableQty: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
