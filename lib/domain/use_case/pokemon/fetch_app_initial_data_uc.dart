import 'package:pokemon_trivia/domain/helper/outcome.dart';
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

  Stream<Outcome<PokemonModel?>> invoke() async* {
    


    final fetchGenerationsResult = await _fetchGenerationsUC.invoke();
    if (fetchGenerationsResult is ErrorOutcome) {
      yield ErrorOutcome(fetchGenerationsResult.error);
    }

    final getGenerationsResult = await _getGenerationsUC.invoke();
    if (getGenerationsResult is ErrorOutcome) {
      yield ErrorOutcome(getGenerationsResult.error);
      return;
    }

    final firstGeneration = (getGenerationsResult as SuccessOutcome).data.first;
    if (firstGeneration!.accessState == GenerationAccessState.pokemonsFetched) {
      return;
    }

    final pokemonsResult = _fetchPokemonsUC.invoke(firstGeneration.code);

    await for (final pokemonModelResult in pokemonsResult) {
      if (pokemonModelResult is ErrorOutcome) {
        yield ErrorOutcome(Errors.errorInItem);
      } else {
        final pokemonModel = pokemonModelResult as SuccessOutcome;
        yield SuccessOutcome(pokemonModel.data!);
      }
    }
  }
}
