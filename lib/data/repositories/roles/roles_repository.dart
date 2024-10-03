import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/employe/models/roles/role_model.dart';

class RoleRepository extends GetxController {
  static RoleRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save menu data to Firestore
  Future<List<RoleModel>> getAllRolesRecord() async {
    try {
      final snapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("roles")
          .get();
      return snapshot.docs.map((e) => RoleModel.fromSnapshot(e)).toList();
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
  Future<void> saveRole(RoleModel roleModel) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("roles")
          .doc(roleModel.roleID)
          .set(roleModel.toJson());
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
  Future<void> updateRole(RoleModel roleModel) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("roles")
          .doc(roleModel.roleID)
          .update(roleModel.toJson());
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
  Future<void> deleteRole(String roleID) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("roles")
          .doc(roleID)
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
