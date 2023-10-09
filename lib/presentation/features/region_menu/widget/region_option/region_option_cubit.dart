import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/region_option_detail_model.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_region_option_detail_model_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/unlock_region.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/coin/coin_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_data.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_state.dart';

class RegionOptionCubit extends Cubit<RegionOptionState> {
  final GetRegionOptionDetailModelUC _getRegionOptionDetailModelUC;
  final UnlockRegionUC _unlockRegionUC;
  final CoinCubit _coinCubit = locator.get<CoinCubit>(); // This is a trash practice

  RegionOptionCubit({
    required GetRegionOptionDetailModelUC getRegionOptionDetailModelUC,
    required UnlockRegionUC unlockRegionUC,
  })  : _getRegionOptionDetailModelUC = getRegionOptionDetailModelUC,
        _unlockRegionUC = unlockRegionUC,
        super(RegionOptionInitialState());

  Future<void> getRegionModel(String generationCode) async {
    final getRegionOptionDetailModelResult =
        await _getRegionOptionDetailModelUC.invoke(generationCode);
    if (getRegionOptionDetailModelResult is ErrorOutcome) {
      emit(RegionOptionErrorState('errorMessage'));
      return;
    }
    final regionOptionDetailModel =
        (getRegionOptionDetailModelResult as SuccessOutcome).data as RegionOptionDetailModel;

    if (regionOptionDetailModel.generationAccessState == GenerationAccessState.locked) {
      final lockedData = RegionOptionLockedOrAvailableData.from(regionOptionDetailModel);
      emit(RegionOptionLockedOrAvailableState(lockedData));
    }

    if (regionOptionDetailModel.generationAccessState == GenerationAccessState.available) {
      final availableData = RegionOptionLockedOrAvailableData.from(regionOptionDetailModel);
      emit(RegionOptionLockedOrAvailableState(availableData));
    }

    if (regionOptionDetailModel.generationAccessState == GenerationAccessState.pokemonsFetched) {
      final readyToPlayData = RegionOptionReadyToPlayData.from(regionOptionDetailModel);
      emit(RegionOptionReadyToPlayState(readyToPlayData));
    }
  }

  Future<void> unlockRegion(String code) async {
    final outcome = await _unlockRegionUC.invoke(code);
    if (outcome is ErrorOutcome) {
      return;
    }
    if ((outcome as SuccessOutcome).data == UnlockRegionResult.regionUnlocked) {
      await getRegionModel(code);
      await _coinCubit.getCoins();
      return;
    }

    if ((outcome as ErrorOutcome).error == Errors.notEnoughCoins) {
      return;
    }

    emit(RegionOptionErrorState("Something went wrong."));
    return;
  }
}
