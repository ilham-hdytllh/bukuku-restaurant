import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/table/models/group_table_model.dart';

class GroupTableRepository extends GetxController {
  static GroupTableRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to get group table data to Firestore
  Future<List<GroupTableModel>> getAllGroupTableRecord() async {
    try {
      final snapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("tableGroups")
          .get();
      return snapshot.docs.map((e) => GroupTableModel.fromSnapshot(e)).toList();
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

  // Function to save group table data to Firestore
  Future<void> saveGroupTable(GroupTableModel groupTable) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("tableGroups")
          .doc(groupTable.groupID)
          .set(groupTable.toJson());
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

  // Function to update group table data to Firestore
  Future<void> updateGroupTable(GroupTableModel groupTable) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("tableGroups")
          .doc(groupTable.groupID)
          .update(groupTable.toJson());
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

  // Function to update status group table data to Firestore
  Future<void> updateStatusGroupTable(String groupTableID, bool status) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("tableGroups")
          .doc(groupTableID)
          .update({"status": status});
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

  // Function to delete group table data to Firestore
  Future<void> deleteGroupTableRecord(String groupID) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("tableGroups")
          .doc(groupID)
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
