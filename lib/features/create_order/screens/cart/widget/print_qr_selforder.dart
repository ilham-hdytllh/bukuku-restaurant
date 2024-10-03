import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class PrintQRCodeSelfOrder extends StatelessWidget {
  const PrintQRCodeSelfOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        height: TSizes.inputFieldHeight - 5,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: TColors.light,
            backgroundColor: TColors.black,
            disabledForegroundColor: TColors.primary,
            disabledBackgroundColor: TColors.buttonDisabled,
            side: const BorderSide(color: TColors.black),
            padding: const EdgeInsets.symmetric(
                vertical: TSizes.buttonHeight - 10, horizontal: 20),
            textStyle: const TextStyle(
                fontSize: 14,
                color: TColors.textWhite,
                fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.qr_code,
            color: TColors.white,
            size: 18,
          ),
          label: const Text(
            "Print QR Self Order",
            style: TextStyle(
                fontSize: 14,
                color: TColors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
