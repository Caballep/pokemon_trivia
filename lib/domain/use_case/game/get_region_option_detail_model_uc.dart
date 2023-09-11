import 'dart:io';

import 'package:pokemon_trivia/domain/helper/generation_cost_helper.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/region_option_detail_model.dart';
import 'package:pokemon_trivia/domain/model/region_score_model.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_region_score_model_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generation_iconic_pokemons_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generation_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generations_uc.dart';

class GetRegionOptionDetailModelUC {
  final GetGenerationScoreUC _getGenerationScoreUC;
  final GetThreeIconicPokemonImagesUC _getThreeIconicPokemonImagesUC;
  final GetGenerationsUC _getGenerationsUC;

  GetRegionOptionDetailModelUC(
      {required GetGenerationScoreUC getGenerationScoreUC,
      required GetGenerationUC getGenerationUC,
      required GetThreeIconicPokemonImagesUC getThreeIconicPokemonImagesUC,
      required GetGenerationsUC getGenerationsUC})
      : _getGenerationScoreUC = getGenerationScoreUC,
        _getThreeIconicPokemonImagesUC = getThreeIconicPokemonImagesUC,
        _getGenerationsUC = getGenerationsUC;

  Future<Outcome<RegionOptionDetailModel?>> invoke(String generationCode) async {
    final getGenerationsOutcome = await _getGenerationsUC.invoke();
    if (getGenerationsOutcome is ErrorOutcome) {
      return getGenerationsOutcome;
    }
    final generationModels =
        (getGenerationsOutcome as SuccessOutcome).data as List<GenerationModel>;

    final generationModel = generationModels.firstWhere((model) => model.code == generationCode);
    if (generationModel.code.isEmpty) {
      return ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
    }

    // When locked
    if (generationModel.accessState == GenerationAccessState.locked) {
      final generationCost = GenerationCostHelper.getCostToUnlock(generationCode);
      final result = RegionOptionDetailModel.from(generationModel, null, null, generationCost);
      return SuccessOutcome(result);
    }

    // When available
    if (generationModel.accessState == GenerationAccessState.available) {
      final result = RegionOptionDetailModel.from(generationModel, null, null, null);
      return SuccessOutcome(result);
    }

    // The following correspond to the third AccessState which is pokemonsFetched
    final getGenerationScoreOutcome = await _getGenerationScoreUC.invoke(generationCode);
    if (getGenerationScoreOutcome is ErrorOutcome) {
      return ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
    }
    final generationScoreModel =
        (getGenerationScoreOutcome as SuccessOutcome).data as GenerationScoreModel;

    final getThreeIconicPokemonImagesOutcome =
        await _getThreeIconicPokemonImagesUC.invoke(generationCode);
    if (getThreeIconicPokemonImagesOutcome is ErrorOutcome) {
      return ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
    }
    final threeIconicPokemonImages =
        (getThreeIconicPokemonImagesOutcome as SuccessOutcome).data as List<File>;

    final result = RegionOptionDetailModel.from(
        generationModel, generationScoreModel, threeIconicPokemonImages, null);

    result.stars = 1;

    return SuccessOutcome(result);
  }
}
