import 'package:pokemon_trivia/core/propagation/result.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';

class CheckPokemonsUpToDateUC {
  final PokemonRepository _pokemonRepository;

  CheckPokemonsUpToDateUC({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository;

  Future<Result<bool>> invoke() {
    final isPokemonUpToDateResult = _pokemonRepository.isPokemonDbUpToDate();
    return isPokemonUpToDateResult;
  }
}
