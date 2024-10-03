import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/menu_and_category/models/menu_model.dart';

class MenuRepository extends GetxController {
  static MenuRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to get all menu data to Firestore
  Future<List<MenuModel>> getAllMenuRecord() async {
    try {
      final snapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("menus")
          .get();
      return snapshot.docs.map((e) => MenuModel.fromSnapshot(e)).toList();
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

  // Function to save menu data to Firestore
  Future<void> saveMenu(MenuModel menu) async {
    try {
      await _db
          .collection("merchants")
          .doc(menu.merchantID)
          .collection("menus")
          .doc(menu.menuID)
          .set(menu.toJson());
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

  // Function to update menu data to Firestore
  Future<void> updateMenu(MenuModel menu) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("menus")
          .doc(menu.menuID)
          .update(menu.toJson());
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

  // Function to delete menu data to Firestore
  Future<void> deleteMenuRecord(String idMenu) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("menus")
          .doc(idMenu)
          .delete();
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
