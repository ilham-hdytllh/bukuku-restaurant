import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/system/controller/address_from_map/address_from_map.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class PickerAdress extends StatelessWidget {
  const PickerAdress({super.key});

  @override
  Widget build(BuildContext context) {
    final addressFromMapController = Get.put(AddressFromMapController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left_copy)),
      ),
      body: OpenStreetMapSearchAndPick(
          locationPinIconColor: TColors.primary,
          buttonColor: TColors.primary,
          buttonTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              color: TColors.textWhite,
              fontWeight: FontWeight.w600),
          locationPinText: "Your Location",
          buttonText: 'Save Address',
          locationPinTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(
                  fontSize: 14,
                  color: TColors.primary,
                  fontWeight: FontWeight.w600),
          onPicked: (pickedData) {
            Map data = pickedData.address;
            String result =
                '${data['road']}, ${data['village']}, ${data['region']}, ${data['postcode']}, ${data['country']}';
            addressFromMapController.addressFromMap.value.text = result;
            addressFromMapController.address.value = result;
            Get.back();
          }),
    );
  }
}
