// region_menu_event.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_coins_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_regions_and_score_model.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_data.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_states.dart';

class RegionMenuCubit extends Cubit<RegionMenuState> {
  final GetRegionsAndScoresModelUC _getRegionsAndScoresModelUC;
  final GetGoinsUC _getGoinsUC;

  RegionMenuCubit(super.initialState,
      {required GetRegionsAndScoresModelUC getRegionsAndScoresModelUC,
      required GetGoinsUC getGoinsUC})
      : _getRegionsAndScoresModelUC = getRegionsAndScoresModelUC,
        _getGoinsUC = getGoinsUC;

  Future<void> getRegionsMenuModel() async {
    final getRegionsAndScoresModelUCOutcome = _getRegionsAndScoresModelUC.invoke();
    if (getRegionsAndScoresModelUCOutcome is ErrorOutcome) {
      emit(RegionMenuErrorState("Quack!"));
      return;
    }
    final regionsAndScoreModel = (getRegionsAndScoresModelUCOutcome as SuccessOutcome).data;

    final getGoinsUCOutcome = _getGoinsUC.invoke();
    if (getGoinsUCOutcome is ErrorOutcome) {
      emit(RegionMenuErrorState("Quack!"));
      return;
    }
    final coins = (getGoinsUCOutcome as SuccessOutcome).data;

    final regionMenuData = RegionMenuData.from(regionsAndScoreModel, coins);

    emit(RegionMenuLoadedState(regionMenuData));
  }
}
