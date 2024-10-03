import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/employe/controller/employes/employee_controller.dart';
import 'package:restaurant_bukuku/features/employe/controller/roles/roles_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class SelectRoleContent extends StatelessWidget {
  final TextEditingController? controller;
  const SelectRoleContent({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final roleController = Get.put(RoleController());
    final employeController = Get.put(EmployeController());
    return Obx(
      () => Scrollbar(
        thumbVisibility: false,
        trackVisibility: false,
        thickness: 8,
        interactive: true,
        radius: const Radius.circular(5),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: roleController.allRoles.length,
          itemBuilder: (context, index) {
            return Obx(
              () => RadioListTile(
                contentPadding: const EdgeInsets.only(right: 5, left: 5),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      roleController.allRoles[index].roleName
                          .toString()
                          .capitalizeAll(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                value: roleController.allRoles[index].roleID,
                groupValue: roleController.selectedRoleID.value,
                activeColor: TColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  // memasukkan role yang dipilih ke variable
                  controller != null
                      ? controller!.text =
                          roleController.allRoles[index].roleName
                      : null;
                  roleController.selectedRoleID.value =
                      roleController.allRoles[index].roleID;
                  employeController.orderBySearch();
                  Get.back();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
