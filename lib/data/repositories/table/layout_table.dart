import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/table/models/table_model.dart';

class LayoutTableRepository extends GetxController {
  static LayoutTableRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to get tableLayouts data to Firestore
  Future<List<TableModelLayout>> getAllLayoutTableRecord() async {
    try {
      final snapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("tableLayouts")
          .get();
      return snapshot.docs
          .map((e) => TableModelLayout.fromSnapshot(e))
          .toList();
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

  // Function to get tableLayouts data to Firestore
  Future<void> saveLayoutTableRecord(TableModelLayout tableModelLayout) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("tableLayouts")
          .doc(tableModelLayout.tableID)
          .set(tableModelLayout.toJson());
    } on FirebaseException catch (e) {
      throw "${e.message}";
    } on FormatException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw "${e.message}";
    } catch (e) {
      throw "Something when wrong, please try again.";
    }
  } // Function to get tableLayouts data to Firestore

  Future<void> deletSpesifikLayoutTableRecord(List<String> tableIDs) async {
    // Mendapatkan referensi koleksi 'table'
    CollectionReference tableCollection = _db
        .collection("merchants")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("tableLayouts");

    try {
      // Memulai batch untuk operasi penghapusan massal
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Mendapatkan dokumen yang akan dihapus berdasarkan daftar ID yang diberikan
      QuerySnapshot querySnapshot =
          await tableCollection.where("tableID", whereIn: tableIDs).get();

      // Iterasi melalui setiap dokumen yang akan dihapus dan tambahkan operasi penghapusan ke batch
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Komit batch untuk mengeksekusi operasi penghapusan
      await batch.commit();
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
