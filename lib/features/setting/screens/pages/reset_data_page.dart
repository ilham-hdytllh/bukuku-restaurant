import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ResetDataPage extends StatelessWidget {
  const ResetDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: TSizes.spaceBtwSections + 30,
            ),
            const Divider(
              thickness: 5,
              color: TColors.primary,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems),
              decoration: const BoxDecoration(
                color: TColors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: TColors.grey),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const Image(
                    image: AssetImage(
                      TImages.trashIcon,
                    ),
                    width: 135,
                    height: 135,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Apabila data telah dihapus, data tidak dapat dikembalikan lagi. Mohon pertimbangkan kembali.",
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Reset Data"),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
