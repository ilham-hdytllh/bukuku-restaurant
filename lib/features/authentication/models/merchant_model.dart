import 'package:cloud_firestore/cloud_firestore.dart';

class MerchantModel {
  final String merchantID;
  final String username;
  final String email;
  final String phoneNumber;
  String restaurantName;
  String restaurantCurrency;
  String restaurantAddress;
  String restaurantLogo;
  List<dynamic> restaurantType;

  MerchantModel({
    required this.merchantID,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.restaurantName,
    required this.restaurantCurrency,
    required this.restaurantAddress,
    required this.restaurantLogo,
    required this.restaurantType,
  });

  // static function to create empty user model
  static MerchantModel empty() => MerchantModel(
        merchantID: "",
        username: "",
        email: "",
        phoneNumber: "",
        restaurantName: "",
        restaurantCurrency: "",
        restaurantAddress: "",
        restaurantLogo: "",
        restaurantType: [],
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'merchantID': merchantID,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'restaurantName': restaurantName,
      'restaurantCurrency': restaurantCurrency,
      'restaurantAddress': restaurantAddress,
      'restaurantLogo': restaurantLogo,
      'restaurantType': restaurantType,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory MerchantModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return MerchantModel(
        merchantID: data["merchantID"] ?? "",
        username: data["username"] ?? "",
        email: data["email"] ?? "",
        phoneNumber: data["phoneNumber"] ?? "",
        restaurantName: data["restaurantName"] ?? "",
        restaurantCurrency: data["restaurantCurrency"] ?? "",
        restaurantAddress: data["restaurantAddress"] ?? "",
        restaurantLogo: data["restaurantLogo"] ?? "",
        restaurantType: data["restaurantType"] ?? [],
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
