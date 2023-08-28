import 'package:pokemon_trivia/data/repo/game_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';

class GetCoinsUC {
  final GameRepository _gameRepository;
  final ResultHandler _resultHandler;

  GetCoinsUC({required GameRepository gameRepository, required ResultHandler resultHandler})
      : _resultHandler = resultHandler,
        _gameRepository = gameRepository;

  Future<Outcome<int?>> invoke() async {
    final getAvailableCoinsResult = await _gameRepository.getAvailableCoins();

    final getAvailableCoinsResultError =
        _resultHandler.handle(getAvailableCoinsResult, errorWhenNull: true);
    if (getAvailableCoinsResultError != null) {
      return Future.value(ErrorOutcome(getAvailableCoinsResultError));
    }

    return Future.value(SuccessOutcome(getAvailableCoinsResult.data));
  }
}
