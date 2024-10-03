import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/// Custom Class for Light & Dark Text Themes
class TTimePickerTheme {
  TTimePickerTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TimePickerThemeData lightTimePickerTheme = TimePickerThemeData(
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
    backgroundColor: TColors.white, // Background color
    hourMinuteTextColor: TColors.black, // Text color for hours and minutes
    dayPeriodTextColor: TColors.black, // Text color for AM/PM
    dayPeriodBorderSide: const BorderSide(
      color: TColors.black,
    ), // Border color for AM/PM
    dialHandColor: TColors.primary, // Color of the hour hand
    dialTextColor: TColors.black, // Text color on the clock dial
    dialBackgroundColor: Colors.deepOrangeAccent.withOpacity(0.2),
    dayPeriodColor: Colors.deepOrangeAccent.withOpacity(0.2),
    hourMinuteColor: Colors.deepOrangeAccent.withOpacity(0.2),
    entryModeIconColor: TColors.black,
    helpTextStyle: const TextStyle(
      color: TColors.black, // Set the text color for "Enter time"
    ),
    hourMinuteTextStyle:
        const TextStyle(fontSize: 30), // Text style for hours and minutes
  );

  /// Customizable Dark Text Theme
  static TimePickerThemeData darkTimePickerTheme = TimePickerThemeData(
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
    backgroundColor: TColors.black, // Background color
    hourMinuteTextColor: TColors.softGrey, // Text color for hours and minutes
    dayPeriodTextColor: TColors.softGrey, // Text color for AM/PM
    dayPeriodBorderSide: const BorderSide(
      color: TColors.primary,
    ), // Border color for AM/PM
    dialHandColor: TColors.softGrey, // Color of the hour hand
    dialTextColor: TColors.black, // Text color on the clock dial
    dialBackgroundColor: TColors.primary,
    dayPeriodColor: TColors.primary,
    hourMinuteColor: TColors.primary,
    entryModeIconColor: TColors.softGrey,
    helpTextStyle: const TextStyle(
      color: TColors.softGrey, // Set the text color for "Enter time"
    ),
    hourMinuteTextStyle: const TextStyle(fontSize: 30), // Text
  );
}
