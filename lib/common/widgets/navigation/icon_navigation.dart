import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class NavigationIcon extends StatelessWidget {
  const NavigationIcon(
      {super.key,
      required this.selected,
      required this.icon,
      required this.label,
      required this.visibility});
  final bool selected, visibility;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return visibility == true
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: selected
                    ? Colors.orangeAccent.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
            width: 100,
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  size: 35,
                  color: selected
                      ? TColors.primary
                      : TColors.darkGrey.withOpacity(0.8),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: TColors.darkerGrey),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
