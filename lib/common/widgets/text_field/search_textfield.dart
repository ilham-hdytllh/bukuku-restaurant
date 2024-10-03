import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

// ignore: must_be_immutable
class SearchTextField extends StatelessWidget {
  SearchTextField(
      {super.key,
      this.controller,
      this.onTap,
      this.onChanged,
      required this.hintText});
  TextEditingController? controller;
  VoidCallback? onTap;
  Function(String)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle()
          .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
      onTapOutside: (value) => FocusScope.of(context).unfocus(),
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: TColors.white,
        filled: true,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: TColors.darkGrey),
        hintText: hintText,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 90,
            decoration: const BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: Center(
              child: Text(
                "Cari",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: TColors.white,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
