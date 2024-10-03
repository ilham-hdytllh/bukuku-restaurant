import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TSwitchheme {
  TSwitchheme._();

  static SwitchThemeData lightSwitchTheme = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      if (states.contains(MaterialState.disabled)) {
        return TColors.darkGrey;
      }
      return TColors.darkGrey;
    }),
    trackColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.orangeAccent.withOpacity(0.2);
      }
      if (states.contains(MaterialState.disabled)) {
        return TColors.grey;
      }
      return TColors.grey;
    }),
    trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
  );

  static SwitchThemeData darkSwitchTheme = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primary;
      }
      if (states.contains(MaterialState.disabled)) {
        return TColors.lightGrey;
      }
      return TColors.lightGrey;
    }),
    trackColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.orangeAccent.withOpacity(0.2);
      }
      if (states.contains(MaterialState.disabled)) {
        return TColors.grey;
      }
      return TColors.grey;
    }),
    trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
  );
}
