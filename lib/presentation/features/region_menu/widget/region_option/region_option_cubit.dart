// region_menu_event.dart
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/region_score_model.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_region_score_model.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generation_iconic_pokemons.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generations_uc.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_data.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_state.dart';

class RegionOptionCubit extends Cubit<RegionOptionState> {
  final GetGenerationScoreUC _getGenerationScoreUC;
  final GetGenerationsUC _getGenerationsUC;
  final GetThreeIconicPokemonImages _getThreeIconicPokemonImages;

  RegionOptionCubit(super.initialState,
      {required GetGenerationScoreUC getGenerationScoreUC,
      required GetGenerationsUC getGenerationsUC,
      required GetThreeIconicPokemonImages getThreeIconicPokemonImages})
      : _getGenerationScoreUC = getGenerationScoreUC,
        _getGenerationsUC = getGenerationsUC,
        _getThreeIconicPokemonImages = getThreeIconicPokemonImages;

  Future<void> getRegionModel(String generationCode) async {
    final getGenerationScoreOutcome = _getGenerationScoreUC.invoke(generationCode);
    if (getGenerationScoreOutcome is ErrorOutcome) {
      emit(RegionOptionErrorState("Quack!"));
      return;
    }
    final generationScoreModel =
        (getGenerationScoreOutcome as SuccessOutcome).data as GenerationScoreModel;

    final getGenerationOutcome = _getGenerationsUC.invoke();
    if (getGenerationOutcome is ErrorOutcome) {
      emit(RegionOptionErrorState("Quack!"));
      return;
    }
    final generationModel = (getGenerationOutcome as SuccessOutcome).data as GenerationModel;

    final getThreeIconicPokemonImagesOutcome =
        await _getThreeIconicPokemonImages.invoke(generationCode);
    if (getThreeIconicPokemonImagesOutcome is ErrorOutcome) {
      emit(RegionOptionErrorState("errorMessage"));
      return;
    }
    final threeIconicPokemonImages =
        (getThreeIconicPokemonImagesOutcome as SuccessOutcome).data as List<File>;

    final regionOptionData =
        RegionOptionData.from(generationModel, generationScoreModel, threeIconicPokemonImages);
    emit(RegionOptionLoadedState(regionOptionData));
  }
}
