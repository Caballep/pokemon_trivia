import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';

class FetchGenerationsUC {
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  FetchGenerationsUC(
      {required GenerationRepository generationRepository, required ResultHandler resultHandler})
      : _generationRepository = generationRepository,
        _resultHandler = resultHandler;

  /// This function will only try to fetch Pokemons only if there is new Pokemon
  /// available in the remote.
  Future<Outcome<void>> invoke() async {
    final localResult = await _generationRepository.getLocalGenerationCount();
    final remoteResult = await _generationRepository.getRemoteGenerationCount();

    final localResultError = _resultHandler.handle(localResult, errorWhenNull: true);
    if (localResultError != null) {
      return ErrorOutcome(localResultError);
    }

    final remoteResultError = _resultHandler.handle(remoteResult, errorWhenNull: true);
    if (remoteResultError != null) {
      // If we are unable to check the remote data for either updating or getting
      //the initial data, we check that at least first generation is stored, if so
      // we can proceed (user is able to play offline)
      if (localResult.data! >= 1) {
        return SuccessOutcome(null);
      }
      return ErrorOutcome(remoteResultError);
    }

    // If local data is up to date with the remote one, move on
    if (localResult.data! >= remoteResult.data!) {
      return SuccessOutcome(null);
    }

    final fetchGenerationsResult = await _generationRepository.fetchGenerations();
    final fetchGenerationsResultError =
        _resultHandler.handle(fetchGenerationsResult, errorWhenNull: true);

    if (fetchGenerationsResultError != null) {
      return ErrorOutcome(fetchGenerationsResultError);
    }

    return SuccessOutcome(fetchGenerationsResult.data);
  }
}
