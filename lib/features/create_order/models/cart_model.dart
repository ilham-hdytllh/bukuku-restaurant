class CartModel {
  final String menuID;
  final String menuName;
  final double price;
  final String image;
  int quantity;
  final String note;

  CartModel({
    required this.menuID,
    required this.menuName,
    required this.price,
    required this.image,
    required this.quantity,
    required this.note,
  });

  // static function to create empty user model
  static CartModel empty() => CartModel(
        menuID: "",
        menuName: "",
        price: 0.0,
        image: "",
        quantity: 0,
        note: "",
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'menuID': menuID,
      'menuName': menuName,
      'price': price,
      'image': image,
      'quantity': quantity,
      'note': note,
    };
  }

  // factory method
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      menuID: json["menuID"] ?? "",
      menuName: json["menuName"] ?? "",
      price: json["price"] ?? 0.0,
      image: json["image"] ?? "",
      quantity: json["quantity"] ?? 0,
      note: json["note"] ?? "",
    );
  }
}
