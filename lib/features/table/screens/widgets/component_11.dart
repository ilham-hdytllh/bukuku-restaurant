import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class Component11 extends StatelessWidget {
  final String tableName;
  const Component11({super.key, required this.tableName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 145,
      width: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: TColors.darkerGrey,
      ),
      child: Text(
        tableName.capitalizeAll(),
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: TColors.white),
      ),
    );
  }
}
