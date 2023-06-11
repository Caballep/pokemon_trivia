import 'package:pokemon_trivia/presentation/features/tos/tos_acceptance_device_data.dart';

import '../../data/source/local/storage/shared_pref/prefs/tos_acceptance_device_pref.dart';

class TosAcceptanceDeviceModel {
  final String? model;
  final String? name;
  final String? osNameAndVersion;
  final String? ip;
  final String? acceptanceTimeStamp;

  TosAcceptanceDeviceModel({
    this.model,
    this.name,
    this.osNameAndVersion,
    this.ip,
    this.acceptanceTimeStamp,
  });

  factory TosAcceptanceDeviceModel.fromTosAcceptanceDevicePref(
      TosAcceptanceDevicePref pref) {
    return TosAcceptanceDeviceModel(
      model: pref.model.value,
      name: pref.name.value,
      osNameAndVersion: pref.osNameAndVersion.value,
      ip: pref.ip.value,
      acceptanceTimeStamp: pref.acceptanceTimeStamp.value,
    );
  }
}
