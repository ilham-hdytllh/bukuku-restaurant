import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String customerID;
  final String customerName;
  final String phoneNumber;
  final String dialCode;
  final String email;
  final String birthdayDate;
  final String address;
  final String province;
  final String city;
  final String district;

  CustomerModel({
    required this.customerID,
    required this.customerName,
    required this.phoneNumber,
    required this.dialCode,
    required this.email,
    required this.birthdayDate,
    required this.address,
    required this.province,
    required this.city,
    required this.district,
  });

  // static function to create empty user model
  static CustomerModel empty() => CustomerModel(
        customerID: "",
        customerName: "",
        phoneNumber: "",
        dialCode: "",
        email: "",
        birthdayDate: "",
        address: "",
        province: "",
        city: "",
        district: "",
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      "customerID": customerID,
      "customerName": customerName,
      "phoneNumber": phoneNumber,
      "dialCode": dialCode,
      "email": email,
      "birthdayDate": birthdayDate,
      "address": address,
      "province": province,
      "city": city,
      "district": district,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory CustomerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CustomerModel(
        customerID: data["customerID"] ?? "",
        customerName: data["customerName"] ?? "",
        phoneNumber: data["phoneNumber"] ?? "",
        dialCode: data["dialCode"] ?? "",
        email: data["email"] ?? "",
        birthdayDate: data["birthdayDate"] ?? "",
        address: data["address"] ?? "",
        province: data["province"] ?? "",
        city: data["city"] ?? "",
        district: data["district"] ?? "",
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
