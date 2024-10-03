import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/data/repositories/authentication/authentication_repository.dart';
import 'package:restaurant_bukuku/features/branch/models/branch_model.dart';

class BranchRepository extends GetxController {
  static BranchRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to get branch data to Firestore
  Future<BranchModel> getBranchRecord(String branchID) async {
    try {
      final documentSnapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("branchs")
          .doc(branchID)
          .get();

      if (documentSnapshot.exists) {
        return BranchModel.fromSnapshot(documentSnapshot);
      } else {
        return BranchModel.empty();
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

  // Function to get all branch data to Firestore
  Future<List<BranchModel>> getAllBranchRecord() async {
    try {
      final snapshot = await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("branchs")
          .get();

      return snapshot.docs.map((e) => BranchModel.fromSnapshot(e)).toList();
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

  // Function to save branch data to Firestore
  Future<void> saveBranch(BranchModel branch) async {
    try {
      await _db
          .collection("merchants")
          .doc(branch.merchantID)
          .collection("branchs")
          .doc(branch.branchID)
          .set(branch.toJson());
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

  // Function to save branch data to Firestore
  Future<void> updateBranch(BranchModel branch) async {
    try {
      await _db
          .collection("merchants")
          .doc(branch.merchantID)
          .collection("branchs")
          .doc(branch.branchID)
          .update(branch.toJson());
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

  // Function to delete branch data to Firestore
  Future<void> deleteBranchRecord(String branchID) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("branchs")
          .doc(branchID)
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

  // Function to update branch spesifik data to Firestore
  Future<void> updateBranchSpesifikData(
      String branchID, String branchName, String branchPhoneNo) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("branchs")
          .doc(branchID)
          .update({
        "branchName": branchName.trim(),
        "branchPhoneNo": branchPhoneNo.trim(),
      });
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

  // Function to update branch address data to Firestore
  Future<void> updateBranchAddress(
      String branchID, String branchAddress) async {
    try {
      await _db
          .collection("merchants")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("branchs")
          .doc(branchID)
          .update({
        "branchAddress": branchAddress.trim(),
      });
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
