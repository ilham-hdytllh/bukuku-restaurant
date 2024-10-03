import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class CustomTapBar extends StatelessWidget {
  final List<String> labelTab;
  const CustomTapBar({super.key, required this.labelTab});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: const EdgeInsets.only(bottom: 5),
      labelPadding: const EdgeInsets.only(right: 14),
      dividerColor: Colors.transparent,
      physics: const NeverScrollableScrollPhysics(),
      splashFactory: NoSplash.splashFactory,
      isScrollable: false,
      tabAlignment: TabAlignment.center,
      indicatorColor: TColors.primary,
      unselectedLabelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: TColors.darkGrey,
          ),
      labelStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: TColors.primary, fontWeight: FontWeight.w600),
      tabs: labelTab
          .map(
            (data) => Tab(
              text: data,
            ),
          )
          .toList(),
    );
  }
}
