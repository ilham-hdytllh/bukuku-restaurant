import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class TLoader {
  static Widget customCircularProgress() => const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: TColors.primary,
          ),
        ),
      );

  static Widget loaderButton() => const Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: TColors.white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Please wait...",
              style: TextStyle(color: TColors.white),
            ),
          ],
        ),
      );
}
