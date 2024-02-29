import 'package:permission_handler/permission_handler.dart';
import 'package:timesync360/core/widgets/dialog/dialog.dart';

class PermissonHandler {
  static Future<bool> requestStoragePermission() async {
    var storagePermission = await Permission.storage.status;

    if (storagePermission.isGranted) {
      return true;
    } else {
      var result = await Permission.storage.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        // showPermissionDialog();
        return false;
      } else {
        return false;
      }
    }
  }
}
