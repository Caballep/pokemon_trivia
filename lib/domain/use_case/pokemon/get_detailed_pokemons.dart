import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/detailed_pokemon_model.dart';

class GetDetailedPokemonsUC {
  final PokemonRepository _pokemonRepository;
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  GetDetailedPokemonsUC(this._pokemonRepository, this._generationRepository, this._resultHandler);

  Future<Outcome<List<DetailedPokemonModel>?>> invoke() async {
    final pokemonsResult = await _pokemonRepository.getPokemons();
    final pokemonsResultError = _resultHandler.handle(pokemonsResult, errorWhenNull: true);
    if (pokemonsResultError != null) {
      return ErrorOutcome(pokemonsResultError);
    }

    final generationResult = await _generationRepository.getGenerations();
    final generationResultError = _resultHandler.handle(generationResult, errorWhenNull: true);
    if (generationResultError != null) {
      return ErrorOutcome(generationResultError);
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
