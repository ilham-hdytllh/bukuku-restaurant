import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderID;
  final String merchantID;
  final String branchID;
  final String cashierName;
  final String customerName;
  final num grossAmount;
  final String orderTime;
  final String salesType;
  final String paymentStatus;
  final List cart;
  final String tableNumber;
  final int pax;

  OrderModel({
    required this.orderID,
    required this.merchantID,
    required this.branchID,
    required this.cashierName,
    required this.customerName,
    required this.grossAmount,
    required this.orderTime,
    required this.salesType,
    required this.paymentStatus,
    required this.cart,
    required this.tableNumber,
    required this.pax,
  });

  // static function to create empty user model
  static OrderModel empty() => OrderModel(
        merchantID: "",
        orderID: "",
        branchID: "",
        cashierName: "",
        customerName: "",
        grossAmount: 0,
        orderTime: "",
        salesType: "",
        paymentStatus: "",
        cart: [],
        tableNumber: "",
        pax: 0,
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      "merchantID": merchantID,
      "orderID": orderID,
      "branchID": branchID,
      "cashierName": cashierName,
      "customerName": customerName,
      "grossAmount": grossAmount,
      "orderTime": orderTime,
      "salesType": salesType,
      "paymentStatus": paymentStatus,
      "cart": cart,
      "tableNumber": tableNumber,
      "pax": pax,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return OrderModel(
        merchantID: data["merchantID"] ?? "",
        orderID: data["orderID"] ?? "",
        branchID: data["branchID"] ?? "",
        cashierName: data["cashierName"] ?? "",
        customerName: data["customerName"] ?? "",
        grossAmount: data["grossAmount"] ?? 0,
        orderTime: data["orderTime"] ?? "",
        salesType: data["salesType"] ?? "",
        paymentStatus: data["paymentStatus"] ?? "",
        cart: data["cart"] ?? [],
        tableNumber: data["tableNumber"] ?? "",
        pax: data["pax"] ?? 0,
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
