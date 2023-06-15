import 'package:pokemon_trivia/core/propagation/error.dart';
import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/core/propagation/result.dart';

class FetchGenerationsUC {
  final GenerationRepository _generationRepository;

  FetchGenerationsUC({required GenerationRepository generationRepository})
      : _generationRepository = generationRepository;

  /// This function will only try to fetch Pokemons only if there is new Pokemon
  /// available in the remote.
  Future<Result<void>> invoke() async {
    final localGeneratioCountnResult =
        await _generationRepository.getLocalGenerationCount();
    final remoteGenerationCountResult =
        await _generationRepository.getRemoteGenerationCount();

    if (localGeneratioCountnResult.isError) {
      return Result.error(localGeneratioCountnResult.error!);
    }

    if (localGeneratioCountnResult.data == null) {
      return Result.error(RepoError.unknown);
    }

    if (remoteGenerationCountResult.isError) {
      return Result.error(remoteGenerationCountResult.error!);
    }

    if (remoteGenerationCountResult.data == null) {
      return Result.error(RepoError.unknown);
    }

    if (localGeneratioCountnResult.data! >= remoteGenerationCountResult.data!) {
      return Result.success(null);
    }

    return await _generationRepository.fetchGenerations();
  }
}
