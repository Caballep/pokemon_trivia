import 'package:pokemon_trivia/data/util/result.dart';
import 'package:pokemon_trivia/core/helpers/date_time_helper.dart';
import 'package:pokemon_trivia/data/repo/service_privacy_repo.dart';

class SaveTosAcceptanceDeviceDataUC {
  final ServicePrivacyRepository _servicePrivacyRepository;
  final DateTimeHelper _dateTimeHelper;

  SaveTosAcceptanceDeviceDataUC(
      {required ServicePrivacyRepository servicePrivacyRepository,
      required DateTimeHelper dateTimeHelper})
      : _servicePrivacyRepository = servicePrivacyRepository,
        _dateTimeHelper = dateTimeHelper;

  Future<Result<void>> invoke() {
    final acceptanceTimeStamp = _dateTimeHelper.getCurrentTimeString();
    return _servicePrivacyRepository.saveTosAcceptanceDeviceData(acceptanceTimeStamp);
  }
}
