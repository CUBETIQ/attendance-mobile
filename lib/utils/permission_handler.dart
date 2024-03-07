import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timesync/core/widgets/dialog/dialog.dart';
import 'package:timesync/utils/logger.dart';

class PermissonHandler {
  static Future<bool> requestStoragePermission() async {
    var storagePermission = await Permission.storage.status;
    Logs.t("Storage Permission: $storagePermission");
    if (storagePermission.isGranted) {
      return true;
    } else {
      var result = await Permission.storage.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        showPermissionDialog(
          "Storage Permission",
          "Storage permission is required. Please enable it from settings",
        );
        return false;
      } else {
        showPermissionDialog(
          "Storage Permission",
          "Storage permission is required. Please enable it from settings",
        );
        return false;
      }
    }
  }

  static Future<bool> requestPhotoPermission() async {
    var photoPermission = await Permission.photos.status;
    Logs.t("Photo Permission: $photoPermission");
    if (photoPermission.isGranted || photoPermission.isLimited) {
      return true;
    } else {
      var result = await Permission.photos.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        showPermissionDialog(
          "Storage Permission",
          "Storage permission is required. Please enable it from settings",
        );
        return false;
      } else {
        showPermissionDialog(
          "Storage Permission",
          "Storage permission is required. Please enable it from settings",
        );
        return false;
      }
    }
  }

  static Future<bool> requestCameraPermission() async {
    var cameraPermission = await Permission.camera.status;
    Logs.t("Camera Permission: $cameraPermission");
    if (cameraPermission.isGranted) {
      return true;
    } else {
      var result = await Permission.camera.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        showPermissionDialog(
          "Camera Permission",
          "Camera permission is required. Please enable it from settings",
        );
        return false;
      } else {
        showPermissionDialog(
          "Camera Permission",
          "Camera permission is required. Please enable it from settings",
        );
        return false;
      }
    }
  }

  static Future<bool> requestLocationPermission() async {
    final locationPermission = await Geolocator.checkPermission();
    Logs.t("Location Permission: $locationPermission");
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      return true;
    } else {
      final requestPermission = await Geolocator.requestPermission();
      if (requestPermission == LocationPermission.always ||
          requestPermission == LocationPermission.whileInUse) {
        return true;
      } else if (requestPermission == LocationPermission.deniedForever) {
        showPermissionDialog(
          "Location Permission",
          "Location permission is required. Please enable it from settings",
        );
        return false;
      } else {
        showPermissionDialog(
          "Location Permission",
          "Location permission is required. Please enable it from settings",
        );
        return false;
      }
    }
  }
}
