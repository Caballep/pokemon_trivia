import 'dart:io';

import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';

class GetThreeIconicPokemonImagesUC {
  final PokemonRepository _pokemonRepository;
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  GetThreeIconicPokemonImagesUC(
      {required PokemonRepository pokemonRepository,
      required GenerationRepository generationRepository,
      required ResultHandler resultHandler})
      : _pokemonRepository = pokemonRepository,
        _generationRepository = generationRepository,
        _resultHandler = resultHandler;

  Future<Outcome<List<File>?>> invoke(String generationCode) async {
    final List<File> threeIconicPokemonImages = [];

    final getGenerationResult = await _generationRepository.getGeneration(generationCode);
    final getGenerationResultError = _resultHandler.handle(getGenerationResult);
    if (getGenerationResultError != null) {
      return ErrorOutcome(getGenerationResultError);
    }
    final generation = getGenerationResult.data!;
    var pokemonNumber = generation.startsWith;

    for (int i = 0; i < 3; i++) {
      final getPokemonResult = await _pokemonRepository.getPokemon(pokemonNumber);
      final getPokemonResultError = _resultHandler.handle(getPokemonResult);
      if (getPokemonResultError != null) {
        return ErrorOutcome(getPokemonResultError);
      }
      final pokemonImageFile = getPokemonResult.data!.imageFile;
      threeIconicPokemonImages.add(pokemonImageFile);
      pokemonNumber += 3;
    }
    return SuccessOutcome(threeIconicPokemonImages);
  }
}
