import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/empty_item/empty_item.dart';
import 'package:restaurant_bukuku/features/report/controllers/sales_report.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/extension/currencyformat.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final salesReportController = Get.put(SalesReportController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      width: double.infinity,
      height: double.infinity,
      color: TColors.softGrey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwInputFields - 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // search sku
                  SizedBox(
                    width: THelperFunctions.screenWidth() * 0.4,
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  dividerThickness: 0.5,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: TColors.grey),
                      color: TColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  headingTextStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: TColors.black),
                  dataTextStyle:
                      Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: TColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                  headingRowHeight: 50,
                  dataRowMaxHeight: 50,
                  dataRowMinHeight: 50,
                  columnSpacing: 5,
                  columns: [
                    const DataColumn(
                      label: Text(
                        'No',
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        'Order ID',
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        'Tanggal',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Customer Name',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Gross Amount',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sales Type',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                      ),
                    ),
                  ],
                  rows: salesReportController.orderInitData.map((element) {
                    return DataRow(cells: [
                      DataCell(
                        Text(
                          (salesReportController.orderInitData
                                      .indexOf(element) +
                                  1)
                              .toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          element.orderID,
                        ),
                      ),
                      DataCell(
                        Text(
                          element.orderTime,
                        ),
                      ),
                      DataCell(
                        Text(
                          element.customerName,
                        ),
                      ),
                      DataCell(
                        Text(
                          CurrencyFormat.convertToIdr(element.grossAmount, 0),
                        ),
                      ),
                      DataCell(
                        Text(
                          element.salesType,
                        ),
                      ),
                      DataCell(
                        Text(
                          element.paymentStatus.capitalizeSingle(),
                          style: TextStyle(
                              color: element.paymentStatus == 'paid'
                                  ? Colors.green
                                  : TColors.textPrimary),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
              Obx(
                () => salesReportController.orderInitData.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: TColors.grey),
                            color: TColors.white,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        height: 250,
                        child: EmptyItem(
                          text: "Tidak ada report",
                          fit: BoxFit.fitWidth,
                          picture: const Icon(
                            Iconsax.box_1_copy,
                            color: TColors.darkGrey,
                            size: TSizes.iconXL,
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
