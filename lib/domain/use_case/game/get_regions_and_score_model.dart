import 'package:pokemon_trivia/data/repo/game_repo.dart';
import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/regions_menu_model.dart';

class GetRegionsAndScoresModelUC {
  final GameRepository _gameRepository;
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  GetRegionsAndScoresModelUC(
      {required GameRepository gameRepository,
      required ResultHandler resultHandler,
      required GenerationRepository generationRepository})
      : _gameRepository = gameRepository,
        _resultHandler = resultHandler,
        _generationRepository = generationRepository;

  Future<Outcome<RegionsAndScoresModel?>> invoke() async {
    final getAllGameScoresResult = await _gameRepository.getAllGameScores();
    final getAllGameScoresResultError = _resultHandler.handle(getAllGameScoresResult);
    if (getAllGameScoresResultError != null) {
      return ErrorOutcome(getAllGameScoresResultError);
    }
    final allGenerationScores = getAllGameScoresResult.data!;

    final totalAllHighestScores = allGenerationScores.fold<int>(
      0,
      (previousValue, score) => previousValue + score.highestScore,
    );

    final getGenerationsResult = await _generationRepository.getGenerations();
    final getGenerationsResultError = _resultHandler.handle(getGenerationsResult);
    if (getGenerationsResultError != null) {
      return ErrorOutcome(getGenerationsResultError);
    }

    final generations = getGenerationsResult.data!;

    // The following 3 variables will be used to fill 3 MapEntry
    String generationCode = '';
    int scoreValue = 0;
    String mainRegionNameKey = '';

    // Getting regionHighestHighestScore MapEntry
    for (var score in allGenerationScores) {
      if (score.highestScore > scoreValue) {
        scoreValue = score.highestScore;
        generationCode = score.generationCode;
      }
    }

    for (var generation in generations) {
      if (generation.code == generationCode) {
        mainRegionNameKey = generation.mainRegionName;
        break;
      }
    }

    MapEntry<String, int> regionHighestHighestScore = MapEntry(mainRegionNameKey, scoreValue);

    generationCode = '';
    scoreValue = 0;
    mainRegionNameKey = '';

    // Getting regionNameHighestHighestStreak MapEntry
    for (var score in allGenerationScores) {
      if (score.highestStreak > scoreValue) {
        scoreValue = score.highestStreak;
        generationCode = score.generationCode;
      }
    }

    for (var generation in generations) {
      if (generation.code == generationCode) {
        mainRegionNameKey = generation.mainRegionName;
        break;
      }
    }

    MapEntry<String, int> regionNameHighestHighestStreak = MapEntry(mainRegionNameKey, scoreValue);

    generationCode = '';
    scoreValue = 0;
    mainRegionNameKey = '';

    // Getting regionNameHighestHighestAnswered MapEntry
    for (var score in allGenerationScores) {
      if (score.highestAnswered > scoreValue) {
        scoreValue = score.highestAnswered;
        generationCode = score.generationCode;
      }
    }

    for (var generation in generations) {
      if (generation.code == generationCode) {
        mainRegionNameKey = generation.mainRegionName;
        break;
      }
    }

    MapEntry<String, int> regionNameHighestHighestAnswered =
        MapEntry(mainRegionNameKey, scoreValue);

    // List of generation codes
    List<String> generationCodes = generations.map((generation) => generation.code).toList();

    // This is the object that will primarly build the generation game menu screen
    final regionsMenuModel = RegionsAndScoresModel(
        allRegionsTotalScore: totalAllHighestScores,
        regionNameHighestHighestScore: regionHighestHighestScore,
        regionNameHighestHighestStreak: regionNameHighestHighestStreak,
        regionNameHighestHighestAnswered: regionNameHighestHighestAnswered,
        generationsCode: generationCodes);

    return SuccessOutcome(regionsMenuModel);
  }
}
