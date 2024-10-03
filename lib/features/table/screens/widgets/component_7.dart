import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/chair_single_sheet_component.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class Component7 extends StatelessWidget {
  final String tableName;
  final int tableQty;
  const Component7({
    super.key,
    required this.tableName,
    required this.tableQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: 110,
      child: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: 70,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    width: 54,
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(2.4),
                      border: Border.all(
                        width: 3,
                        color: TColors.primary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        tableName.capitalizeAll(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: TColors.white),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      ChairSingleSheet(),
                      SizedBox(
                        width: TSizes.spaceBtwText,
                      ),
                      ChairSingleSheet(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: TSizes.spaceBtwText + 5,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SizedBox(
                height: double.infinity,
                width: 28,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.2, bottom: 7.2),
                      child: Container(
                        height: double.infinity,
                        width: 4,
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2.4),
                            bottomLeft: Radius.circular(2.4),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 6,
                          width: 18,
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(2.4),
                              bottomRight: Radius.circular(2.4),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 1.2,
                        ),
                        Expanded(
                          child: Container(
                            width: 18,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: TColors.primary.withOpacity(0.7),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 1.2,
                        ),
                        Container(
                          height: 6,
                          width: 18,
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2.4),
                              topRight: Radius.circular(2.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 1.2,
                    ),
                    Container(
                      height: double.infinity,
                      width: 4,
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(2.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
