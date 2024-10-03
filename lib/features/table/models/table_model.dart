import 'package:cloud_firestore/cloud_firestore.dart';

class TableModelLayout {
  final String branchID;
  final String groupID;
  final String groupName;
  final String tableID;
  final String tableName;
  final String componentID;
  double offsetDx;
  double offsetDy;
  final int maxQty;
  final bool status;
  final bool rotate;

  TableModelLayout({
    required this.branchID,
    required this.groupID,
    required this.groupName,
    required this.tableID,
    required this.tableName,
    required this.componentID,
    required this.offsetDx,
    required this.offsetDy,
    required this.maxQty,
    required this.status,
    required this.rotate,
  });

  // static function to create empty user model
  static TableModelLayout empty() => TableModelLayout(
        branchID: "",
        groupID: "",
        groupName: "",
        tableID: "",
        tableName: "",
        componentID: "",
        offsetDx: 0.0,
        offsetDy: 0.0,
        maxQty: 1,
        status: true,
        rotate: false,
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      "branchID": branchID,
      "groupID": groupID,
      "groupName": groupName,
      "tableID": tableID,
      "tableName": tableName,
      "componentID": componentID,
      "offsetDx": offsetDx,
      "offsetDy": offsetDy,
      "maxQty": maxQty,
      "status": status,
      "rotate": rotate,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory TableModelLayout.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return TableModelLayout(
        branchID: data["branchID"] ?? "",
        groupID: data["groupID"] ?? "",
        groupName: data["groupName"] ?? "",
        tableID: data["tableID"] ?? "",
        tableName: data["tableName"] ?? "",
        componentID: data["componentID"] ?? "",
        offsetDx: data["offsetDx"] ?? 0.0,
        offsetDy: data["offsetDy"] ?? 0.0,
        maxQty: data["maxQty"] ?? 1,
        status: data["status"] ?? true,
        rotate: data["rotate"] ?? false,
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
