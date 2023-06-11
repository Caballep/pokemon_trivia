import 'package:pokemon_trivia/data/source/local/device/device_info_data.dart';
import 'package:pokemon_trivia/domain/model/tos_acceptance_device_model.dart';

class TosAcceptanceDevicePref {
  static const String modelKey = "TosAcceptanceDeviceModel";
  static const String nameKey = "TosAcceptanceDeviceName";
  static const String osNameAndVersionKey =
      "TosAcceptanceDeviceOsNameAndVersion";
  static const String ipKey = "TosAcceptanceDeviceIp";
  static const String acceptanceTimeStampKey =
      "TosAcceptanceDeviceAcceptanceTimeStamp";

  late final MapEntry<String, String?> model;
  late final MapEntry<String, String?> name;
  late final MapEntry<String, String?> osNameAndVersion;
  late final MapEntry<String, String?> ip;
  late final MapEntry<String, String?> acceptanceTimeStamp;

  TosAcceptanceDevicePref({
    String? model,
    String? name,
    String? osNameAndVersion,
    String? ip,
    String? acceptanceTimeStamp,
  }) {
    this.model = MapEntry(modelKey, model);
    this.name = MapEntry(nameKey, name);
    this.osNameAndVersion = MapEntry(osNameAndVersionKey, osNameAndVersion);
    this.ip = MapEntry(ipKey, ip);
    this.acceptanceTimeStamp =
        MapEntry(acceptanceTimeStampKey, acceptanceTimeStamp);
  }

  factory TosAcceptanceDevicePref.fromDeviceInfoData(
      DeviceInfoData deviceInfoData, String ip, String timeStampString) {
    return TosAcceptanceDevicePref(
      model: deviceInfoData.model,
      name: deviceInfoData.name,
      osNameAndVersion: "${deviceInfoData.osName} ${deviceInfoData.osVersion}",
      ip: ip,
      acceptanceTimeStamp: timeStampString,
    );
  }

  factory TosAcceptanceDevicePref.fromTosAcceptanceDeviceModel(
      TosAcceptanceDeviceModel model) {
    return TosAcceptanceDevicePref(
      model: model.model,
      name: model.name,
      osNameAndVersion: model.osNameAndVersion,
      ip: model.ip,
      acceptanceTimeStamp: model.acceptanceTimeStamp,
    );
  }
}
