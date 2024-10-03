import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/// Custom Class for Light & Dark Text Themes
class TDatePickerTheme {
  TDatePickerTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
    ),
    elevation: 0,
    confirmButtonStyle: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    cancelButtonStyle: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    backgroundColor: TColors.white,
    surfaceTintColor: Colors.transparent,
    headerForegroundColor: TColors.white,
    headerBackgroundColor: TColors.primary,
    dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      return TColors.white;
    }),
    todayForegroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.white;
      }
      return TColors.primary;
    }),
    todayBackgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      return TColors.white;
    }),
    yearBackgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      return TColors.white;
    }),
  );

  /// Customizable Dark Text Theme
  static DatePickerThemeData darkDatePickerTheme = DatePickerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
    ),
    elevation: 0,
    confirmButtonStyle: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    cancelButtonStyle: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    backgroundColor: TColors.black,
    surfaceTintColor: Colors.transparent,
    headerForegroundColor: TColors.black,
    headerBackgroundColor: TColors.primary,
    dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      return TColors.black;
    }),
    todayForegroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.black;
      }
      return TColors.primary;
    }),
    todayBackgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      return TColors.black;
    }),
    yearBackgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      return TColors.black;
    }),
  );
}
