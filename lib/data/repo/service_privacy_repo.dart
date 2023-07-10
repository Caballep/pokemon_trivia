import 'package:pokemon_trivia/data/util/result.dart';
import 'package:pokemon_trivia/data/source/local/device/device_info_source.dart';
import 'package:pokemon_trivia/data/source/local/storage/shared_pref/prefs/tos_acceptance_device_pref.dart';
import 'package:pokemon_trivia/data/source/local/storage/shared_pref/shared_pref.dart';
import 'package:pokemon_trivia/data/source/remote/api/ipify_api.dart';
import 'package:pokemon_trivia/domain/model/tos_acceptance_device_model.dart';

class ServicePrivacyRepository {
  final IpifyApi _ipifyApi;
  final DeviceInfoSource _deviceInfoSource;
  final SharedPref _sharedPref;

  ServicePrivacyRepository(
      {required SharedPref sharedPref,
      required IpifyApi ipifyApi,
      required DeviceInfoSource deviceInfoSource})
      : _sharedPref = sharedPref,
        _ipifyApi = ipifyApi,
        _deviceInfoSource = deviceInfoSource;

  Future<Result<void>> saveTosAcceptanceDeviceData(String acceptanceTimeStamp) async {
    try {
      final deviceInfo = await _deviceInfoSource.getDeviceInfo();
      final ip = await _ipifyApi.getIP();
      final dateTimeStampString = acceptanceTimeStamp;
      final tosAcceptanceDevicePref =
          TosAcceptanceDevicePref.fromDeviceInfoData(deviceInfo, ip, dateTimeStampString);

      await _sharedPref.saveTosAcceptanceDeviceData(tosAcceptanceDevicePref);

      return Result.success(null);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<TosAcceptanceDeviceModel>> getTosAcceptanceDevice() async {
    try {
      final pref = await _sharedPref.getTosAcceptanceDevicePref();
      final model = TosAcceptanceDeviceModel.fromTosAcceptanceDevicePref(pref);
      return Result.success(model);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }
}
