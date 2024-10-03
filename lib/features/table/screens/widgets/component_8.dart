import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class Component8 extends StatelessWidget {
  final String tableName;
  final int tableQty;
  const Component8({
    super.key,
    required this.tableName,
    required this.tableQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 28,
                width: 110,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(2.4),
                      ),
                    ),
                    const SizedBox(
                      height: 1.2,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 18,
                          width: 6,
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(2.4),
                              bottomRight: Radius.circular(2.4),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 1.2,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 18,
                            decoration: BoxDecoration(
                              color: TColors.primary.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.2),
                      child: Container(
                        height: 4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(2.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwText,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.7),
                      border: Border.all(
                        width: 3,
                        color: TColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwText,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.7),
                      border: Border.all(
                        width: 3,
                        color: TColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 85,
            width: 28,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 4,
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 1.2,
                ),
                SizedBox(
                  height: 75,
                  width: 28,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.2),
                        child: Container(
                          height: double.infinity,
                          width: 4,
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(2.4),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(2.4),
                                bottomLeft: Radius.circular(2.4))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
