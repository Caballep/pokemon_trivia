import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:pokemon_trivia/data/source/local/device/device_info_data.dart';
import 'package:http/http.dart' as http;

class DeviceInfoSource {
  final DeviceInfoPlugin _deviceInfoPlugin;

  DeviceInfoSource(this._deviceInfoPlugin);

  Future<DeviceInfoData> getDeviceInfo() async {
    DeviceInfoData deviceInfoData = DeviceInfoData(
      model: '',
      name: '',
      osName: '',
      osVersion: '',
      ip: '',
    );

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceInfoData = DeviceInfoData(
          model: androidInfo.model,
          name: androidInfo.device,
          osName: androidInfo.version.baseOS ?? 'android',
          osVersion: androidInfo.version.release,
          ip: await _getIP(),
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceInfoData = DeviceInfoData(
          model: iosInfo.model,
          name: iosInfo.name,
          osName: iosInfo.systemName,
          osVersion: iosInfo.systemVersion,
          ip: await _getIP(),
        );
      }
    } catch (e) {
      // Handle error if unable to retrieve device information
    }

    return deviceInfoData;
  }

  Future<String> _getIP() async {
    try {
      // Make a request to a public API to retrieve the IP address
      final response = await http.get(Uri.parse('https://api.ipify.org'));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      // Handle error if unable to retrieve the IP address
    }

    // Return a default IP address if retrieval fails
    return '127.0.0.1'; // Placeholder IP address
  }
}
