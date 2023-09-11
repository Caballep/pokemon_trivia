import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/region_option_detail_model.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_region_option_detail_model_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/unlock_region.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_data.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_state.dart';

class RegionOptionCubit extends Cubit<RegionOptionState> {
  final GetRegionOptionDetailModelUC _getRegionOptionDetailModelUC;
  final UnlockRegionUC _unlockRegionUC;

  RegionOptionCubit({
    required GetRegionOptionDetailModelUC getRegionOptionDetailModelUC,
    required UnlockRegionUC unlockRegionUC,
  })  : _getRegionOptionDetailModelUC = getRegionOptionDetailModelUC,
        _unlockRegionUC = unlockRegionUC,
        super(RegionOptionInitialState());

  Future<void> getRegionModel(String generationCode) async {
    if (generationCode == 'III') {
      emit(RegionOptionLockedOrAvailableState(RegionOptionLockedOrAvailableData(
          code: "VIII", name: "Bibulite", unlockCoinCost: 0, unlocked: true)));
      return;
    }

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
      return; // TODO: Handle this, need a game dialog
    }
    if ((outcome as SuccessOutcome).data == UnlockRegionResult.regionUnlocked) {
      await getRegionModel(code);
      return;
    }
    // dialog to notify there is not enought coins
    return;
  }
}
