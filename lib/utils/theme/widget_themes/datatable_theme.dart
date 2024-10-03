import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TDataTableTheme {
  TDataTableTheme._();

  static DataTableThemeData lightDataTableTheme = DataTableThemeData(
    dividerThickness: 0.5,
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: TColors.grey),
        color: TColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5))),
    headingTextStyle: const TextStyle(
      fontSize: 14.0,
      color: TColors.black,
      fontWeight: FontWeight.w600,
    ),
    dataTextStyle: const TextStyle(
      fontSize: 14.0,
      color: TColors.black,
      fontWeight: FontWeight.w400,
    ),
    headingRowHeight: 50,
    dataRowMaxHeight: 50,
    dataRowMinHeight: 50,
    columnSpacing: 5,
  );

  static DataTableThemeData darkDataTableTheme = DataTableThemeData(
    dividerThickness: 0.5,
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: TColors.grey),
        color: TColors.black,
        borderRadius: const BorderRadius.all(Radius.circular(5))),
    headingTextStyle: const TextStyle(
      fontSize: 14.0,
      color: TColors.white,
      fontWeight: FontWeight.w600,
    ),
    dataTextStyle: const TextStyle(
      fontSize: 14.0,
      color: TColors.white,
      fontWeight: FontWeight.w400,
    ),
    headingRowHeight: 50,
    dataRowMaxHeight: 50,
    dataRowMinHeight: 50,
    columnSpacing: 5,
  );
}
