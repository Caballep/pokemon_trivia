import 'package:pokemon_trivia/data/repo/game_repo.dart';
import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/model/region_score_model.dart';

class GetGenerationScoreUC {
  final GameRepository _gameRepository;
  final ResultHandler _resultHandler;

  GetGenerationScoreUC({
    required GameRepository gameRepository,
    required GenerationRepository generationRepository,
    required ResultHandler resultHandler,
  })  : _gameRepository = gameRepository,
        _resultHandler = resultHandler;

  Future<Outcome<GenerationScoreModel?>> invoke(String generationCode) async {
    final getGameScoreResult = await _gameRepository.getGameScore(generationCode);
    final getGameScoreResultError = _resultHandler.handle(getGameScoreResult);
    if (getGameScoreResultError != null) {
      return ErrorOutcome(getGameScoreResultError);
    }
    return SuccessOutcome(getGameScoreResult.data!);
  }
}
