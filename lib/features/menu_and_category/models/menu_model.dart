import 'package:cloud_firestore/cloud_firestore.dart';

class MenuModel {
  final String menuID;
  final String merchantID;
  final String branchID;
  final String menuName;
  final String menuImage;
  final String description;
  final String category;
  final bool allowFlexiblePrice;
  final double price;
  final List recipes;
  final List addons;

  MenuModel({
    required this.menuID,
    required this.merchantID,
    required this.branchID,
    required this.menuName,
    required this.menuImage,
    required this.description,
    required this.category,
    required this.allowFlexiblePrice,
    required this.price,
    required this.recipes,
    required this.addons,
  });

  // static function to create empty user model
  static MenuModel empty() => MenuModel(
        menuID: "",
        merchantID: "",
        branchID: "",
        menuName: "",
        menuImage: "",
        description: "",
        category: "",
        allowFlexiblePrice: false,
        price: 0,
        recipes: [],
        addons: [],
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'menuID': menuID,
      'merchantID': merchantID,
      'branchID': branchID,
      'menuName': menuName,
      'menuImage': menuImage,
      'description': description,
      'category': category,
      'allowFlexiblePrice': allowFlexiblePrice,
      'price': price,
      'recipes': recipes,
      'addons': addons,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory MenuModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return MenuModel(
        menuID: data["menuID"] ?? "",
        merchantID: data["merchantID"] ?? "",
        branchID: data["branchID"] ?? "",
        menuName: data["menuName"] ?? "",
        menuImage: data["menuImage"] ?? "",
        description: data["description"] ?? "",
        category: data["category"] ?? "",
        allowFlexiblePrice: data["allowFlexiblePrice"] ?? false,
        price: data["price"] ?? 0,
        recipes: data["recipes"] ?? [],
        addons: data["addons"] ?? [],
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
