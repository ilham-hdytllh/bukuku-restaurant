import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class Component15 extends StatelessWidget {
  final String tableName;
  const Component15({super.key, required this.tableName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 130,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.orangeAccent,
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
