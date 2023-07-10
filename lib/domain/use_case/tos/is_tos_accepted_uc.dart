import 'package:pokemon_trivia/data/util/result.dart';
import 'package:pokemon_trivia/data/repo/service_privacy_repo.dart';

class IsTosAcceptedUC {
  final ServicePrivacyRepository _servicePrivacyRepository;

  IsTosAcceptedUC({required ServicePrivacyRepository servicePrivacyRepository})
      : _servicePrivacyRepository = servicePrivacyRepository;

  Future<Result<bool>> invoke() async {
    final tosAcceptanceDevice =
        await _servicePrivacyRepository.getTosAcceptanceDevice();

    if (tosAcceptanceDevice.data?.acceptanceTimeStamp == null) {
      return Result.success(false);
    }

    return Result.success(true);
  }
}
