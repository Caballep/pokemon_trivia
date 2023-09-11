// region_menu_event.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/use_case/game/add_coins_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_coins_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_regions_and_score_model_uc.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_data.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_states.dart';

class RegionMenuCubit extends Cubit<RegionMenuState> {
  final GetRegionsAndScoresModelUC _getRegionsAndScoresModelUC;
  final AddCoinsUC _addCoinsUC;
  final GetCoinsUC _getCoinsUC;

  RegionMenuCubit(
      {required GetRegionsAndScoresModelUC getRegionsAndScoresModelUC,
      required GetCoinsUC getCoinsUC,
      required AddCoinsUC addCoins}) // THIS SHOULD NOT BE A UC, but be part of purchase UC
      : _getRegionsAndScoresModelUC = getRegionsAndScoresModelUC,
        _getCoinsUC = getCoinsUC,
        _addCoinsUC = addCoins,
        super(RegionMenuInitialState());

  Future<void> getRegionsMenuModel() async {
    final getRegionsAndScoresModelUCOutcome = await _getRegionsAndScoresModelUC.invoke();
    if (getRegionsAndScoresModelUCOutcome is ErrorOutcome) {
      emit(RegionMenuErrorState("Quack!"));
      return;
    }
    final regionsAndScoreModel = (getRegionsAndScoresModelUCOutcome as SuccessOutcome).data;

    final getGoinsUCOutcome = await _getCoinsUC.invoke();
    if (getGoinsUCOutcome is ErrorOutcome) {
      emit(RegionMenuErrorState("Quack!"));
      return;
    }
    final coins = (getGoinsUCOutcome as SuccessOutcome).data;

    final regionMenuData = RegionMenuData.from(regionsAndScoreModel, coins);

    emit(RegionMenuLoadedState(regionMenuData));
  }

  Future<void> fireCoinEasterEgg() async {
    await _addCoinsUC.invoke(999);
  }
}
