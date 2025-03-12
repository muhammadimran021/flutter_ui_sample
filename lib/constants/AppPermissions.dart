import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static Future<Map<Permission, PermissionStatus>> requestPermissions(
    List<Permission> permission,
  ) async {
    final statuses = await permission.request();

    return statuses;
  }

  static Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  static Future<bool> requestSinglePermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      print("Storage Permission Granted");
      return true;
    } else if (status.isDenied) {
      print("Storage Permission Denied");
      return false;
    } else if (status.isPermanentlyDenied) {
      print("Storage Permission Permanently Denied");
      openAppSettings(); // Open settings if permanently denied
    }
    return false;
  }

  static List<Permission> getPhotosPermissionList() {
    List<Permission> permissionList = [
      /// iOS & Android 33+
      Permission.photos,

      /// for android 32 and below
      Permission.storage,
    ];
    return permissionList;
  }
}
