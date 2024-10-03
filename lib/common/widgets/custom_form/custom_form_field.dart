import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class CustomFormField extends FormField<bool> {
  CustomFormField(
      {super.key,
      required Widget page,
      required GetxController roleController,
      required bool initialValue,
      required FormFieldValidator<bool> validator,
      AutovalidateMode? autovalidateMode})
      : super(
            initialValue: initialValue,
            autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
            validator: validator,
            builder: (FormFieldState<bool> state) {
              return UnmanagedRestorationScope(
                bucket: state.bucket,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: page),
                    state.hasError
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              state.errorText!,
                              style: const TextStyle(color: TColors.error),
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            });
}
