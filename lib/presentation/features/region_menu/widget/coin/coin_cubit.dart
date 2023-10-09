import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/use_case/game/add_coins_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_coins_uc.dart';

class CoinCubit extends Cubit<CoinState> {
  final AddCoinsUC _addCoinsUC;
  final GetCoinsUC _getCoinsUC;

  int tapCount = 0;
  late DateTime lastTapTime;

  CoinCubit({
    required AddCoinsUC addCoinsUC,
    required GetCoinsUC getCoinsUC,
  })  : _addCoinsUC = addCoinsUC,
        _getCoinsUC = getCoinsUC,
        super(CoinInitialState()) {
    lastTapTime = DateTime.now();
  }

  Future<void> getCoins() async {
    final getCoinsUCOutcome = await _getCoinsUC.invoke();
    if (getCoinsUCOutcome is ErrorOutcome) {
      emit(CoinErrorGettingState());
      return;
    }
    final getCoinsUCData = (getCoinsUCOutcome as SuccessOutcome).data;
    if (getCoinsUCData == null) {
      emit(CoinErrorGettingState());
      return;
    }
    final coins = getCoinsUCData!;
    emit(CoinResultState(coins));
  }

  Future<void> addCoins(int amount) async {
    final addCoinsUCOutcome = await _addCoinsUC.invoke(amount);
    if (addCoinsUCOutcome is ErrorOutcome) {
      emit(CoinErrorAddingState());
    }
    await getCoins();
  }

  Future<void> handleEaterEggClick() async {
    final now = DateTime.now();
    final timeDiff = now.difference(lastTapTime);

    if (timeDiff <= const Duration(milliseconds: 500)) {
      tapCount++;
    } else {
      tapCount = 1;
    }

    lastTapTime = now;

    if (tapCount >= 10) {
      await addCoins(999);
      await getCoins();
      tapCount = 0;
    }
  }
}

abstract class CoinState {}

class CoinInitialState extends CoinState {}

class CoinResultState extends CoinState {
  final int coins;

  CoinResultState(this.coins);
}

class CoinErrorGettingState extends CoinState {}

class CoinErrorAddingState extends CoinState {}
