import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/customer/customer_repository.dart';
import 'package:restaurant_bukuku/features/customer/models/customer_model.dart';
import 'package:restaurant_bukuku/features/system/controller/dialcode/dialcode_controller.dart';
import 'package:restaurant_bukuku/utils/helpers/network_manager.dart';
import 'package:restaurant_bukuku/utils/snackbar/snackbar.dart';

class CustomerController extends GetxController {
  static CustomerController get instance => Get.find();

  final customerRepository = Get.put(CustomerRepository());

  // Variable
  GlobalKey<FormState> customerFormKey = GlobalKey();
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingGet = false.obs;
  RxBool isLoadingDelete = false.obs;
  Rx<String> text = ''.obs;
  Rx<String> selectedCustomerID = ''.obs;
  Rx<int> hitung = 0.obs;
  Rx<int> maxLength = 200.obs;
  Rx<TextEditingController> searchCustomer = TextEditingController().obs;
  final phoneNumber = TextEditingController();
  final customerName = TextEditingController();
  final email = TextEditingController();
  final birthdayDate = TextEditingController();
  final address = TextEditingController();
  Rx<TextEditingController> province = TextEditingController().obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> district = TextEditingController().obs;
  Rx<TextEditingController> postalCode = TextEditingController().obs;
  RxList<CustomerModel> allCustomer = <CustomerModel>[].obs;
  RxList<CustomerModel> allCustomerToTable = <CustomerModel>[].obs;

  @override
  void onInit() {
    fetchAllCustomerRecord();
    super.onInit();
  }

  // get all customer record
  Future<void> fetchAllCustomerRecord() async {
    try {
      // show loading
      isLoadingGet.value = true;
      // pick data
      final customers = await customerRepository.getAllCustomerRecord();
      // asign customer
      allCustomer.assignAll(customers);
      allCustomerToTable.assignAll(customers);

      // stop loading
      isLoadingGet.value = false;
    } catch (e) {
      // stop loading
      isLoadingGet.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error get data role", message: "Please try again later");
    }
  }

  // delete customer
  Future<void> deleteCustomerRecord(String customerID) async {
    try {
      // show loading
      isLoadingDelete.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingDelete.value = false;
        return;
      }

      // call controller customer repository
      final customerRepository = Get.put(CustomerRepository());
      // Save branch data in the firebase database
      await customerRepository.deleteCustomerRecord(customerID);

      // back to customer screen
      Get.back();

      await fetchAllCustomerRecord();

      // stop loading
      isLoadingDelete.value = false;
    } catch (e) {
      // stop loading
      isLoadingDelete.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error delete role", message: "Please try again later");
    }
  }

  // save customer in firebase
  Future<void> saveCustomerRecord() async {
    final dialCode = Get.put(DialCodeController());

    try {
      // show loading
      isLoadingAdd.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingAdd.value = false;
        return;
      }

      // form validation
      if (!customerFormKey.currentState!.validate()) {
        isLoadingAdd.value = false;
        return;
      }

      // create generic id from datetime epoch
      final String genericID = DateTime.now().millisecondsSinceEpoch.toString();

      // put data in model
      final newCustomer = CustomerModel(
        customerID: "cust-$genericID",
        customerName: customerName.value.text.trim(),
        phoneNumber: phoneNumber.value.text.trim(),
        dialCode: dialCode.selectedCodePhoneString.value,
        email: email.value.text.trim(),
        birthdayDate: birthdayDate.value.text.trim(),
        address: address.value.text.trim(),
        province: province.value.text.trim(),
        city: city.value.text.trim(),
        district: district.value.text.trim(),
      );
      // call controller customer repository
      final customerRepository = Get.put(CustomerRepository());
      // Save customer data in the firebase database
      await customerRepository.saveCustomer(newCustomer);

      customerName.clear();
      email.clear();
      birthdayDate.clear();
      address.clear();
      province.value.clear();
      city.value.clear();
      district.value.clear();
      phoneNumber.clear();

      // back to customer screen
      Get.back(id: 8);

      await fetchAllCustomerRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Customer added", message: "Customer success added");

      // stop loading
      isLoadingAdd.value = false;
    } catch (e) {
      // stop loading
      isLoadingAdd.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error save customer", message: "Please try again later");
    }
  }

  // set to update view
  void setVariableToUpdate(
      String customerIDData,
      String customerNameData,
      String dialCodeData,
      String phoneNumberData,
      String emailData,
      String birthdayDateData,
      String addressData,
      String provinceData,
      String cityData,
      String districtData) {
    final dialCodeContrller = Get.put(DialCodeController());
    dialCodeContrller.codePhoneString.value = dialCodeData;
    selectedCustomerID.value = customerIDData;
    customerName.text = customerNameData;
    phoneNumber.text = phoneNumberData;
    email.text = emailData;
    birthdayDate.text = birthdayDateData;
    address.text = addressData;
    province.value.text = provinceData;
    city.value.text = cityData;
    district.value.text = districtData;
  }

  // update role in firebase
  Future<void> updateCustomerRecord(String customerID) async {
    final dialCode = Get.put(DialCodeController());
    try {
      // show loading
      isLoadingUpdate.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoadingUpdate.value = false;
        return;
      }

      // form validation
      if (!customerFormKey.currentState!.validate()) {
        isLoadingUpdate.value = false;
        return;
      }

      // put data in model
      final updateCustomer = CustomerModel(
        customerID: customerID,
        customerName: customerName.value.text.trim(),
        phoneNumber: phoneNumber.value.text.trim(),
        dialCode: dialCode.selectedCodePhoneString.value,
        email: email.value.text.trim(),
        birthdayDate: birthdayDate.value.text.trim(),
        address: address.value.text.trim(),
        province: province.value.text.trim(),
        city: city.value.text.trim(),
        district: district.value.text.trim(),
      );
      // call controller customer repository
      final customerRepository = Get.put(CustomerRepository());
      // Save customer data in the firebase database
      await customerRepository.updateCustomer(updateCustomer);

      customerName.clear();
      email.clear();
      birthdayDate.clear();
      address.clear();
      province.value.clear();
      city.value.clear();
      district.value.clear();
      phoneNumber.clear();

      // back to customer screen
      Get.back(id: 8);

      await fetchAllCustomerRecord();

      // show success dialog
      CustomSnackbar.successSnackbar(
          title: "Customer updated", message: "Customer success updated");

      // stop loading
      isLoadingUpdate.value = false;
    } catch (e) {
      // stop loading
      isLoadingUpdate.value = false;
      // error message
      CustomSnackbar.errorSnackbar(
          title: "Error update customer", message: "Please try again later");
    }
  }

  // orderirng branch data by search
  void orderBySearch() async {
    List<CustomerModel> filterData({
      required List<CustomerModel> data,
      required String namaSearchField,
    }) {
      return data
          .where((element) => element.customerName
              .trim()
              .toLowerCase()
              .contains(
                  searchCustomer.value.text.toString().trim().toLowerCase()))
          .toList(growable: false);
    }

    if (searchCustomer.value.text.isNotEmpty) {
      // Mengupdate filteredCurrencyCodeData dengan data yang sudah difilter
      List<CustomerModel> updateData = filterData(
          data: allCustomer, namaSearchField: searchCustomer.value.text);
      allCustomerToTable.assignAll(updateData);
    } else {
      allCustomerToTable.assignAll(allCustomer);
    }
  }
}
