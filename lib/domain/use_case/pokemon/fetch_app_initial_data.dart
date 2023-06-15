import 'package:pokemon_trivia/core/propagation/result.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_generations_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generations_uc.dart';

class FetchInitialDataAndGetPokemonsUC {
  final FetchGenerationsUC _fetchGenerationsUC;
  final FetchPokemonsUC _fetchPokemonsUC;
  final GetGenerationsUC _getGenerationsUC;

  FetchInitialDataAndGetPokemonsUC(
      {required FetchGenerationsUC fetchGenerationsUC,
      required FetchPokemonsUC fetchPokemonsInRangeUC,
      required GetGenerationsUC getGenerationsUC})
      : _fetchGenerationsUC = fetchGenerationsUC,
        _fetchPokemonsUC = fetchPokemonsInRangeUC,
        _getGenerationsUC = getGenerationsUC;

  Stream<Result<PokemonModel>> invoke() async* {
    await _fetchGenerationsUC.invoke();
    final generations = await _getGenerationsUC.invoke();
    final firstGeneration = generations.data?.first;

    if (firstGeneration!.accessState == GenerationAccessState.pokemonsFetched) {
      return;
    }

    final pokemonStream = _fetchPokemonsUC.invoke(generations.data!.first.code);
    await for (final pokemonModel in pokemonStream) {
      yield pokemonModel;
    }
  }
}
