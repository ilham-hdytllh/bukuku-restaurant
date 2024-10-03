import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class SearchBasic extends StatelessWidget {
  const SearchBasic({super.key, this.controller, this.hintText});
  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.trash),
        ),
        border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
          borderSide: const BorderSide(width: 1, color: TColors.darkGrey),
        ),
        enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
          borderSide: const BorderSide(width: 1, color: TColors.darkGrey),
        ),
        focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
          borderSide: const BorderSide(width: 1, color: TColors.primary),
        ),
      ),
      style: const TextStyle()
          .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
      onTapOutside: (value) => FocusScope.of(context).unfocus(),
    );
  }
}
