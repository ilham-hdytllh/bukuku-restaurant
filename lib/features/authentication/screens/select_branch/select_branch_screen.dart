import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/common/styles/spacing_styles.dart';
import 'package:restaurant_bukuku/common/widgets/select_account_and_branch/select_branch_body.dart';
import 'package:restaurant_bukuku/common/widgets/select_account_and_branch/select_branch_header.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class SelectBranchScreen extends StatelessWidget {
  const SelectBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(orientation == Orientation.landscape
                    ? TImages.backgroundAuth
                    : TImages.backgroundAuthRotate),
                opacity: 0.1,
                fit: BoxFit.cover),
          ),
          child: const SingleChildScrollView(
            child: Padding(
              padding: TSpacingStyle.paddingWithAppbarHeight,
              child: Column(
                children: [
                  // Logo app, signout button
                  SelectBranchHeader(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // list account
                  SelectBranchBody(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
