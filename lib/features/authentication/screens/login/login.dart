import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/styles/spacing_styles.dart';
import 'package:restaurant_bukuku/common/widgets/login_signup/header_log_sign.dart';
import 'package:restaurant_bukuku/common/widgets/login_signup/not_have_account.dart';
import 'package:restaurant_bukuku/common/widgets/login_signup/social_buttons_tablet.dart';
import 'package:restaurant_bukuku/features/authentication/screens/login/widget/login_form_tablet.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          child: SingleChildScrollView(
            child: Padding(
              padding: TSpacingStyle.paddingWithAppbarHeight,
              child: Column(
                children: [
                  // Logo app, title, sub title
                  const THeaderAuthPage(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // Form
                  const TLoginForm(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Not hace account
                  const TNotHaveAccount(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Footer
                  const TSocialButtons(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  Text(
                    "appName".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),

                  Text(
                    "appVersion".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
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
