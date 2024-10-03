import 'package:cloud_firestore/cloud_firestore.dart';

class GroupTableModel {
  final String branchID;
  final String groupID;
  final String groupName;
  final bool status;

  GroupTableModel({
    required this.branchID,
    required this.groupID,
    required this.groupName,
    required this.status,
  });

  // static function to create empty user model
  static GroupTableModel empty() => GroupTableModel(
        branchID: "",
        groupID: "",
        groupName: "",
        status: false,
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      "branchID": branchID,
      "groupID": groupID,
      "groupName": groupName,
      "status": status,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory GroupTableModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return GroupTableModel(
        branchID: data["branchID"] ?? "",
        groupID: data["groupID"] ?? "",
        groupName: data["groupName"] ?? "",
        status: data["status"] ?? false,
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
