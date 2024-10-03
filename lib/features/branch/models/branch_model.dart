import 'package:cloud_firestore/cloud_firestore.dart';

class BranchModel {
  final String branchID;
  final String merchantID;
  final String branchName;
  final String branchAddress;
  final String branchDialCode;
  final String branchPhoneNo;
  final String branchEmail;

  BranchModel({
    required this.branchID,
    required this.merchantID,
    required this.branchName,
    required this.branchAddress,
    required this.branchDialCode,
    required this.branchPhoneNo,
    required this.branchEmail,
  });

  // static function to create empty user model
  static BranchModel empty() => BranchModel(
        merchantID: "",
        branchID: "",
        branchName: "",
        branchAddress: "",
        branchDialCode: "",
        branchPhoneNo: "",
        branchEmail: "",
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'branchID': branchID,
      'merchantID': merchantID,
      'branchName': branchName,
      'branchAddress': branchAddress,
      'branchDialCode': branchDialCode,
      'branchPhoneNo': branchPhoneNo,
      'branchEmail': branchEmail,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory BranchModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return BranchModel(
        branchID: data["branchID"] ?? "",
        merchantID: data["merchantID"] ?? "",
        branchName: data["branchName"] ?? "",
        branchAddress: data["branchAddress"] ?? "",
        branchDialCode: data["branchDialCode"] ?? "",
        branchPhoneNo: data["branchPhoneNo"] ?? "",
        branchEmail: data["branchEmail"] ?? "",
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
