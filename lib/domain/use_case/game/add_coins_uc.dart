import 'package:pokemon_trivia/data/repo/game_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';

class AddCoinsUC {
  final ResultHandler _resultHandler;
  final GameRepository _gameRepository;

  AddCoinsUC({required ResultHandler resultHandler, required GameRepository gameRepository})
      : _resultHandler = resultHandler,
        _gameRepository = gameRepository;

  Future<Outcome<void>> invoke(int amount) async {
    final addCoinsResult = await _gameRepository.addCoins(amount);

    final addCoinsResultError = _resultHandler.handle(addCoinsResult);
    if (addCoinsResultError != null) {
      Future.value(ErrorOutcome(addCoinsResultError));
    }
    return Future.value(SuccessOutcome(null));
  }
}
