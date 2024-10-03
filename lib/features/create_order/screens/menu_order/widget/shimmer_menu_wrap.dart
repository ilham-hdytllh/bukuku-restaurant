import 'package:flutter/widgets.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMenuWrap extends StatelessWidget {
  const ShimmerMenuWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.start,
        runSpacing: 20,
        spacing: 20,
        children: [
          for (int a = 0; a < 9; a++) ...{
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: 170,
              height: 180,
              child: Shimmer.fromColors(
                baseColor: TColors.darkGrey,
                highlightColor: TColors.grey,
                child: const SizedBox(),
              ),
            ),
          }
        ],
      ),
    );
  }
}
