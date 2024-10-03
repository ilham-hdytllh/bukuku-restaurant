import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String categoryID;
  final String merchantID;
  final String branchID;
  final String categoryName;

  CategoryModel({
    required this.categoryID,
    required this.merchantID,
    required this.branchID,
    required this.categoryName,
  });

  // static function to create empty user model
  static CategoryModel empty() => CategoryModel(
        categoryID: "",
        merchantID: "",
        branchID: "",
        categoryName: "",
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'categoryID': categoryID,
      'merchantID': merchantID,
      'branchID': branchID,
      'categoryName': categoryName,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        categoryID: data["categoryID"] ?? "",
        merchantID: data["merchantID"] ?? "",
        branchID: data["branchID"] ?? "",
        categoryName: data["categoryName"] ?? "",
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
