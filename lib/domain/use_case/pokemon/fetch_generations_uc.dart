import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/exception_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';

class FetchGenerationsUC {
  final GenerationRepository _generationRepository;
  final ExceptionHandler _exceptionHandler;

  FetchGenerationsUC(
      {required GenerationRepository generationRepository,
      required ExceptionHandler exceptionHandler})
      : _generationRepository = generationRepository,
        _exceptionHandler = exceptionHandler;

  /// This function will only try to fetch Pokemons only if there is new Pokemon
  /// available in the remote.
  Future<Outcome<void>> invoke() async {
    final localResult = await _generationRepository.getLocalGenerationCount();
    final remoteResult = await _generationRepository.getRemoteGenerationCount();

    if (localResult.isError) {
      final error = _exceptionHandler.handleAndGetError(localResult.exceptionData!);
      return ErrorOutcome(error);
    }

    if (localResult.data == null) {
      return ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
    }

    if (remoteResult.isError) {
      final error = _exceptionHandler.handleAndGetError(remoteResult.exceptionData!);
      return ErrorOutcome(error);
    }

    if (remoteResult.data == null) {
      return ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
    }

    // If local data is up to date with the remote one, move on
    if (localResult.data! >= remoteResult.data!) {
      return SuccessOutcome(null);
    }

    final result = await _generationRepository.fetchGenerations();

    if (result.isError) {
      final error = _exceptionHandler.handleAndGetError(result.exceptionData!);
      return ErrorOutcome(error);
    }

    if (result.isSuccess) {
      return SuccessOutcome(result.data);
    }

    return ErrorOutcome(Errors.unknown);
  }
}
