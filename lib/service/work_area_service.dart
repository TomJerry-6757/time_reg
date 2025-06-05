import 'dart:developer' as developer;

import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class WorkAreaInfo {
  final String? wifiName;
  final String? wifiBSSID;
  final Position? position;
  final String statusMessage;
  final bool isSuccessful;

  WorkAreaInfo({this.wifiName, this.wifiBSSID, this.position, required this.statusMessage, required this.isSuccessful});
}

class WorkAreaService {
  final NetworkInfo _networkInfo = NetworkInfo();

  Future<WorkAreaInfo> getWorkAreaDetails() async {
    String? tempWifiName;
    String? tempWifiBSSID;
    Position? currentPosition;
    String statusMessage = "";
    bool isSuccessful = false;

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          statusMessage = 'Location permissions are denied.';
          developer.log(statusMessage);

          return WorkAreaInfo(statusMessage: statusMessage, isSuccessful: false);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        statusMessage = 'Location permissions are permanently denied. Please enable them in app settings.';
        developer.log(statusMessage);

        return WorkAreaInfo(statusMessage: statusMessage, isSuccessful: false);
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        statusMessage = 'Location services are disabled. Please enable them.';
        developer.log(statusMessage);
        return WorkAreaInfo(statusMessage: statusMessage, isSuccessful: false);
      }

      try {
        currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, timeLimit: const Duration(seconds: 10));
        if (currentPosition.isMocked) {
          statusMessage = 'Mock location detected. ${currentPosition}';
          developer.log(statusMessage);
          return WorkAreaInfo(statusMessage: statusMessage, isSuccessful: false);
        }
      } catch (e) {
        statusMessage = 'Could not get current location: $e';
        developer.log(statusMessage);
        return WorkAreaInfo(statusMessage: statusMessage, isSuccessful: false);
      }

      if (currentPosition == null) {
        statusMessage = 'Failed to retrieve location.';
        developer.log(statusMessage);
        return WorkAreaInfo(statusMessage: statusMessage, isSuccessful: false);
      }

      try {
        tempWifiName = await _networkInfo.getWifiName();
        tempWifiBSSID = await _networkInfo.getWifiBSSID();

        if (tempWifiName != null && tempWifiName.startsWith('"') && tempWifiName.endsWith('"')) {
          tempWifiName = tempWifiName.substring(1, tempWifiName.length - 1);
        }
      } catch (e) {
        developer.log('Warning: Could not get Wi-Fi info: $e');
      }

      isSuccessful = true;
      statusMessage = 'Successfully retrieved location and Wi-Fi info.';
      developer.log('WorkAreaService success: $statusMessage');

      return WorkAreaInfo(wifiName: tempWifiName, wifiBSSID: tempWifiBSSID, position: currentPosition, statusMessage: statusMessage, isSuccessful: true);
    } catch (e) {
      statusMessage = "An unexpected error occurred in WorkAreaService: $e";
      developer.log(statusMessage);
      return WorkAreaInfo(statusMessage: statusMessage, isSuccessful: false);
    }
  }

  Future<void> openAppSettingsForPermissions() async {
    await openAppSettings();
  }
}
