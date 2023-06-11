import 'package:pokemon_trivia/data/source/local/storage/shared_pref/prefs/tos_acceptance_device_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences _prefs;

  Future<void> saveTosAcceptanceDeviceData(TosAcceptanceDevicePref pref) async {
    _prefs = await SharedPreferences.getInstance();
    _trySaveStringPreference(pref.model);
    _trySaveStringPreference(pref.name);
    _trySaveStringPreference(pref.osNameAndVersion);
    _trySaveStringPreference(pref.ip);
    _trySaveStringPreference(pref.acceptanceTimeStamp);
  }

  Future<TosAcceptanceDevicePref> getTosAcceptanceDevicePref() async {
    _prefs = await SharedPreferences.getInstance();
    return TosAcceptanceDevicePref(
      model: _prefs.getString(TosAcceptanceDevicePref.modelKey),
      name: _prefs.getString(TosAcceptanceDevicePref.nameKey),
      osNameAndVersion: _prefs.getString(TosAcceptanceDevicePref.osNameAndVersionKey),
      ip: _prefs.getString(TosAcceptanceDevicePref.ipKey),
      acceptanceTimeStamp:
          _prefs.getString(TosAcceptanceDevicePref.acceptanceTimeStampKey),
    );
  }

  _trySaveStringPreference(MapEntry mapEntry) {
    if (mapEntry.value != null) {
      _prefs.setString(mapEntry.key, mapEntry.value);
    } else {
      final valueInKey = _prefs.getString(mapEntry.key);
      if (valueInKey == null) {
        _prefs.setString(mapEntry.key, "");
      }
    }
  }
}
