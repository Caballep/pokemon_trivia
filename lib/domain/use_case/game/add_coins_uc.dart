import 'package:pokemon_trivia/data/repo/game_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';

class AddCoinsUC {
  final ResultHandler _resultHandler;
  final GameRepository _gameRepository;

  AddCoinsUC({required ResultHandler resultHandler, required GameRepository gameRepository})
      : _resultHandler = resultHandler,
        _gameRepository = gameRepository;

  // This Use Case ensures that the amount of coins does not go above 999
  Future<Outcome<void>> invoke(int amountToAdd) async {
    final getAvailableCoinsResult = await _gameRepository.getAvailableCoins();

    final getAvailableCoinsResultError =
        _resultHandler.handle(getAvailableCoinsResult, errorWhenNull: true);
    if (getAvailableCoinsResultError != null) {
      return Future.value(ErrorOutcome(getAvailableCoinsResultError));
    }

    final currentPlayerCoins = getAvailableCoinsResult.data!;
    final expectedTotalCoins = currentPlayerCoins + amountToAdd;

    int coinsToAdd = 0;
    if (expectedTotalCoins > 999) {
      coinsToAdd = 999 - currentPlayerCoins;
    } else {
      coinsToAdd = amountToAdd;
    }

    final addCoinsResult = await _gameRepository.addCoins(coinsToAdd);

    final addCoinsResultError = _resultHandler.handle(addCoinsResult);
    if (addCoinsResultError != null) {
      Future.value(ErrorOutcome(addCoinsResultError));
    }
    return Future.value(SuccessOutcome(null));
  }
}
