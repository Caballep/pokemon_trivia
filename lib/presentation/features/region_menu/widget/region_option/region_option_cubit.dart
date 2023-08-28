import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/region_option_detail_model.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_region_option_detail_model_uc.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_data.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_state.dart';

class RegionOptionCubit extends Cubit<RegionOptionState> {
  final GetRegionOptionDetailModelUC _getRegionOptionDetailModelUC;

  RegionOptionCubit({
    required GetRegionOptionDetailModelUC getRegionOptionDetailModelUC,
  })  : _getRegionOptionDetailModelUC = getRegionOptionDetailModelUC,
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
      final lockedData = RegionOptionLockedData.from(regionOptionDetailModel);
      emit(RegionOptionLockedState(lockedData));
    }

    if (regionOptionDetailModel.generationAccessState == GenerationAccessState.available) {
      final availableData = RegionOptionAvailableData.from(regionOptionDetailModel);
      emit(RegionOptionAvailableState(availableData));
    }

    if (regionOptionDetailModel.generationAccessState == GenerationAccessState.pokemonsFetched) {
      final readyToPlayData = RegionOptionReadyToPlayData.from(regionOptionDetailModel);
      emit(RegionOptionReadyToPlayState(readyToPlayData));
    }
  }
  
}
