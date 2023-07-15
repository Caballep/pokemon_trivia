import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/domain/helper/exception_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/detailed_pokemon_model.dart';

class GetDetailedPokemonsUC {
  final PokemonRepository _pokemonRepository;
  final GenerationRepository _generationRepository;
  final ExceptionHandler _exceptionHandler;

  GetDetailedPokemonsUC(
      this._pokemonRepository, this._generationRepository, this._exceptionHandler);

  Future<Outcome<List<DetailedPokemonModel>?>> invoke() async {
    final pokemonsResult = await _pokemonRepository.getPokemons();

    if (pokemonsResult.isError) {
      final error = _exceptionHandler.handleAndGetError(pokemonsResult.exceptionData!);
      return ErrorOutcome(error);
    }

    if (pokemonsResult.data == null) {
      return ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
    }

    final generationResult = await _generationRepository.getGenerations();

    if (generationResult.isError) {
      final error = _exceptionHandler.handleAndGetError(generationResult.exceptionData!);
      return ErrorOutcome(error);
    }

    if (generationResult.data == null) {
      return ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
    }

    final pokemons = pokemonsResult.data!;
    final generations = generationResult.data!;

    final detailedPokemons = pokemons.map((pokemon) {
      final generation = generations
          .firstWhere((gen) => pokemon.number >= gen.startsWith && pokemon.number <= gen.endsWith);
      return DetailedPokemonModel.from(pokemon, generation);
    }).toList();

    return SuccessOutcome(detailedPokemons);
  }
}
