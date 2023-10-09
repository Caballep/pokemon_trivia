import 'package:pokemon_trivia/data/repo/game_repo.dart';
import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/generation_cost_helper.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';

class UnlockRegionUC {
  final GameRepository _gameRepository;
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  UnlockRegionUC(
      {required GenerationRepository generationRepository,
      required ResultHandler resultHandler,
      required GameRepository gameRepository})
      : _generationRepository = generationRepository,
        _resultHandler = resultHandler,
        _gameRepository = gameRepository;

  Future<Outcome<UnlockRegionResult?>> invoke(String generationCode) async {
    final generationCost = GenerationCostHelper.getCostToUnlock(generationCode);

    final getAvailableCoinsResult = await _gameRepository.getAvailableCoins();

    final getAvailableCoinsResultError =
        _resultHandler.handle(getAvailableCoinsResult, errorWhenNull: true);
    if (getAvailableCoinsResultError != null) {
      return Future.value(ErrorOutcome(getAvailableCoinsResultError));
    }
    final availableCoins = getAvailableCoinsResult.data!;

    if (availableCoins >= generationCost) {
      final result = await _generationRepository.updateGenerationAccessState(
          generationCode, GenerationAccessState.available);
      final error = _resultHandler.handle(result);
      if (error != null) {
        return ErrorOutcome(error);
      }

      final substractCoinsResult = await _gameRepository.substractCoins(generationCost);

      final substractCoinsResultError = _resultHandler.handle(substractCoinsResult);
      if (substractCoinsResultError != null) {
        return Future.value(ErrorOutcome(substractCoinsResultError));
      }

      return SuccessOutcome(UnlockRegionResult.regionUnlocked);
    } else {
      return SuccessOutcome(UnlockRegionResult.insufficientCoins);
    }
  }
}

enum UnlockRegionResult { regionUnlocked, insufficientCoins }
