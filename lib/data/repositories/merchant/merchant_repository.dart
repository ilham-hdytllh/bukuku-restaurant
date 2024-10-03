import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/authentication/models/merchant_model.dart';

class MerchantRepository extends GetxController {
  static MerchantRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data to Firestore
  Future<void> saveMerchantRecord(MerchantModel merchant) async {
    try {
      await _db
          .collection("merchants")
          .doc(merchant.merchantID)
          .set(merchant.toJson());
    } on FirebaseException catch (e) {
      throw "${e.message}";
    } on FormatException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw "${e.message}";
    } catch (e) {
      throw "Something when wrong, please try again.";
    }
  }

  Future<void> updateMerchantRecord(Map<String, dynamic> data) async {
    try {
      // Perbarui dokumen merchant dengan nilai-nilai yang sudah diperbarui
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(
            data, // Data yang akan digunakan untuk menambah atau memperbarui dokumen
          );
    } on FirebaseException catch (e) {
      throw "${e.message}";
    } on FormatException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw "${e.message}";
    } catch (e) {
      throw "Something when wrong, please try again.";
    }
  }

  // update merchant spesifik data
  Future<void> updateMerchantSpesifikData(
      String merchantName, String merchantLogo) async {
    try {
      // Perbarui dokumen merchant dengan nilai-nilai yang sudah diperbarui
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(
        {
          "restaurantName": merchantName,
          "restaurantLogo": merchantLogo,
        }, // Data yang akan digunakan untuk menambah atau memperbarui dokumen
      );
    } on FirebaseException catch (e) {
      throw "${e.message}";
    } on FormatException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw "${e.message}";
    } catch (e) {
      throw "Something when wrong, please try again.";
    }
  }

  // Function to save user data to Firestore
  Future<MerchantModel> getMerchantRecord() async {
    try {
      final documentSnapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return MerchantModel.fromSnapshot(documentSnapshot);
      } else {
        return MerchantModel.empty();
      }
    } on FirebaseException catch (e) {
      throw "${e.message}";
    } on FormatException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw "${e.message}";
    } catch (e) {
      throw "Something when wrong, please try again.";
    }
  }
}
