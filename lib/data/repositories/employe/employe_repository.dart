import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/employe/models/employe/employe_model.dart';

class EmployeRepository extends GetxController {
  static EmployeRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to get employe data to Firestore
  Future<EmployeModel> getEmployeRecord(String employeID) async {
    try {
      final documentSnapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("employes")
          .doc(employeID)
          .get();

      if (documentSnapshot.exists) {
        return EmployeModel.fromSnapshot(documentSnapshot);
      } else {
        return EmployeModel.empty();
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

  // Function to get all employe data to Firestore
  Future<List<EmployeModel>> getAllEmployeRecord() async {
    try {
      final snapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("employes")
          .get();
      return snapshot.docs.map((e) => EmployeModel.fromSnapshot(e)).toList();
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

  // Function to save employe data to Firestore
  Future<void> saveEmploye(EmployeModel employe) async {
    try {
      await _db
          .collection("merchants")
          .doc(employe.merchantID)
          .collection("employes")
          .doc(employe.employeID)
          .set(employe.toJson());
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

  // Function to update employe data to Firestore
  Future<void> updateEmploye(EmployeModel employe) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("employes")
          .doc(employe.employeID)
          .update(employe.toJson());
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

  // Function to update employe data to Firestore
  Future<void> updateEmployeName(String employeID, String employeName) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("employes")
          .doc(employeID)
          .update({"employeName": employeName.trim()});
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

  // Function to delete employe data to Firestore
  Future<void> deleteEmployeRecord(String idEmploye) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("employes")
          .doc(idEmploye)
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
