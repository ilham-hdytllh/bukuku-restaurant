import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class CustomRadioListTile extends StatelessWidget {
  const CustomRadioListTile(
      {super.key,
      required this.title,
      required this.value,
      required this.grupValue,
      required this.onChanged});
  final String title, value, grupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: RadioListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        value: value,
        groupValue: grupValue,
        activeColor: TColors.primary,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
      ),
    );
  }
}
