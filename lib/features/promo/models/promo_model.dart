import 'package:cloud_firestore/cloud_firestore.dart';

class PromoModel {
  final String branchID;
  final String promoID;
  final String promoType;
  final String discountType;
  final String promoName;
  final String promoDescription;
  final double discountPercent;
  final double maximumDiscount;
  final double discountAmount;
  final double minimumPurchase;
  final String promotionActiveType;
  final String startDate;
  final String endDate;
  final List activeDays;
  final bool promotionHour;
  final String startHour;
  final String endHour;
  final List menuPromotions;
  final List categoryPromotions;
  final int qtyMultiplePurchase;

  PromoModel({
    required this.branchID,
    required this.promoID,
    required this.promoType,
    required this.discountType,
    required this.promoName,
    required this.promoDescription,
    required this.maximumDiscount,
    required this.discountPercent,
    required this.discountAmount,
    required this.minimumPurchase,
    required this.promotionActiveType,
    required this.startDate,
    required this.endDate,
    required this.activeDays,
    required this.promotionHour,
    required this.startHour,
    required this.endHour,
    required this.menuPromotions,
    required this.categoryPromotions,
    required this.qtyMultiplePurchase,
  });

  // static function to create empty user model
  static PromoModel empty() => PromoModel(
        branchID: "",
        promoID: "",
        promoType: "",
        discountType: "",
        promoName: "",
        promoDescription: "",
        maximumDiscount: 0,
        discountPercent: 0,
        discountAmount: 0,
        minimumPurchase: 0,
        promotionActiveType: "",
        startDate: "",
        endDate: "",
        activeDays: [],
        promotionHour: false,
        startHour: "",
        endHour: "",
        categoryPromotions: [],
        menuPromotions: [],
        qtyMultiplePurchase: 0,
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      "branchID": branchID,
      "promoID": promoID,
      "promoType": promoType,
      "discountType": discountType,
      "promoName": promoName,
      "promoDescription": promoDescription,
      "maximumDiscount": maximumDiscount,
      "discountPercent": discountPercent,
      "discountAmount": discountAmount,
      "minimumPurchase": minimumPurchase,
      "promotionActiveType": promotionActiveType,
      "startDate": startDate,
      "endDate": endDate,
      "activeDays": activeDays,
      "promotionHour": promotionHour,
      "startHour": startHour,
      "endHour": endHour,
      "menuPromotions": menuPromotions,
      "categoryPromotions": categoryPromotions,
      "qtyMultiplePurchase": qtyMultiplePurchase,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory PromoModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return PromoModel(
        branchID: data["branchID"] ?? "",
        promoID: data["promoID"] ?? "",
        promoType: data["promoType"] ?? "",
        discountType: data["discountType"] ?? "",
        promoName: data["promoName"] ?? "",
        promoDescription: data["promoDescription"] ?? "",
        maximumDiscount: data["maximumDiscount"] ?? 0,
        discountPercent: data["discountPercent"] ?? 0,
        discountAmount: data["discountAmount"] ?? 0,
        minimumPurchase: data["minimumPurchase"] ?? 0,
        promotionActiveType: data["promotionActiveType"] ?? "",
        startDate: data["startDate"] ?? "",
        endDate: data["endDate"] ?? "",
        activeDays: data["activeDays"] ?? [],
        promotionHour: data["promotionHour"] ?? false,
        startHour: data["startHour"] ?? "",
        endHour: data["endHour"] ?? "",
        categoryPromotions: data["categoryPromotions"] ?? [],
        menuPromotions: data["menuPromotions"] ?? [],
        qtyMultiplePurchase: data["qtyMultiplePurchase"] ?? 0,
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
