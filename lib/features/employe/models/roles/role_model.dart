import 'package:cloud_firestore/cloud_firestore.dart';

class RoleModel {
  final String roleID;
  final String roleName;
  final Map<String, dynamic> permissions;

  RoleModel({
    required this.roleID,
    required this.roleName,
    required this.permissions,
  });

  // static function to create empty user model
  static RoleModel empty() => RoleModel(
        roleID: "",
        roleName: "",
        permissions: {},
      );

  // convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'roleID': roleID,
      'roleName': roleName,
      'permissions': permissions,
    };
  }

  // factory method to create a User Model form a Firebase document snapshot
  factory RoleModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return RoleModel(
        roleID: data["roleID"] ?? "",
        roleName: data["roleName"] ?? "",
        permissions: data["permissions"] ?? {},
      );
    } else {
      throw Exception("Data is null");
    }
  }
}
