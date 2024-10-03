import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeModel {
  final String employeID;
  final String merchantID;
  final String branchID;
  final String employeName;
  final String employeEmail;
  final String role;
  final String pin;

  EmployeModel({
    required this.employeID,
    required this.merchantID,
    required this.branchID,
    required this.employeName,
    required this.employeEmail,
    required this.role,
    required this.pin,
  });

  // static function to create empty user model
  static EmployeModel empty() => EmployeModel(
        merchantID: "",
        employeID: "",
        branchID: "",
        employeName: "",
        employeEmail: "",
        role: "",
        pin: "",
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'employeID': employeID,
      'merchantID': merchantID,
      'branchID': branchID,
      'employeName': employeName,
      'employeEmail': employeEmail,
      'role': role,
      'pin': pin,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory EmployeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return EmployeModel(
        employeID: data["employeID"] ?? "",
        merchantID: data["merchantID"] ?? "",
        branchID: data["branchID"] ?? "",
        employeName: data["employeName"] ?? "",
        employeEmail: data["employeEmail"] ?? "",
        role: data["role"] ?? "",
        pin: data["pin"] ?? "",
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
