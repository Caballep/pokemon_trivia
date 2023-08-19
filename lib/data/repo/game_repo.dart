import 'package:pokemon_trivia/data/source/local/db/entity/game_score_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/game_dao.dart';
import 'package:pokemon_trivia/data/util/result.dart';
import 'package:pokemon_trivia/domain/model/region_score_model.dart';

class GameRepository {
  final GameDao _gameDao;

  GameRepository({required GameDao gameDao}) : _gameDao = gameDao;

  Future<Result<int>> getAvailableCoins() async {
    try {
      final availableCoins = await _gameDao.getCoins();
      return Result.success(availableCoins);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<void>> addCoins(int amount) async {
    try {
      await _gameDao.addCoins(amount);
      return Result.success(null);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<GenerationScoreModel>> getGameScore(String generationCode) async {
    try {
      final gameScoreResult = await _gameDao.getGameScore(generationCode);
      final gameScoreModel = GenerationScoreModel.from(gameScoreResult!);
      return Result.success(gameScoreModel);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<List<GenerationScoreModel>>> getAllGameScores() async {
    try {
      final gameScoresResult = await _gameDao.getAllGameScores();
      final gameScoreModels = gameScoresResult.map((e) => GenerationScoreModel.from(e)).toList();
      return Result.success(gameScoreModels);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<void>> setRegionScore(GenerationScoreModel regionScoreModel) async {
    try {
      final gameScoreEntity = GameScoreEntity.from(regionScoreModel);
      await _gameDao.setGameScore(gameScoreEntity);
      return Result.success(null);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }
}
