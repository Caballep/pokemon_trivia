import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class FetchPokemonsUC {
  final PokemonRepository _pokemonRepository;
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  FetchPokemonsUC(
      {required PokemonRepository pokemonRepository,
      required GenerationRepository generationRepository,
      required ResultHandler resultHandler})
      : _pokemonRepository = pokemonRepository,
        _generationRepository = generationRepository,
        _resultHandler = resultHandler;

  /// This function will only try to fetch Pokemons only if there is new Pokemon
  /// available in the remote.
  Stream<Outcome<PokemonModel?>> invoke(String generationCode) async* {
    final generationResult = await _generationRepository.getGeneration(generationCode);
    final generationResultError = _resultHandler.handle(generationResult, errorWhenNull: true);
    if (generationResultError != null) {
      yield ErrorOutcome(generationResultError);
      return;
    }

    // No need to verify if there is an error, both error or null data is acceptable
    final lastFetchedPokemonResult =
        await _generationRepository.getLastFetchedPokemon(generationCode);
    final lastFetchedPokemon = lastFetchedPokemonResult.data;

    final firstPokemon = generationResult.data!.startsWith;
    final lastPokemon = generationResult.data!.endsWith;

    final nextPokemon = lastFetchedPokemon != null && lastFetchedPokemon >= firstPokemon
        ? lastFetchedPokemon
        : firstPokemon;

    final temporalDeleteThis = (firstPokemon + 19); // make this a flag for testing

    // for (int i = firstPokemon; i <= lastPokemon + 1; i++) { TODO
    for (int i = nextPokemon; i <= temporalDeleteThis + 1; i++) {
      final pokemon = await _pokemonRepository.fetchPokemon(i);
      if (pokemon.isError) {
        yield ErrorOutcome(Errors.nullItem);
      } else {
        await _generationRepository.setLastFetchedPokemon(generationCode, i);
        yield SuccessOutcome(pokemon.data);
      }
    }

    final updateAccessStateResult = await _generationRepository.updateGenerationAccessState(
        generationResult.data!.code, GenerationAccessState.pokemonsFetched);

    final updateAccessStateResultError = _resultHandler.handle(updateAccessStateResult);

    if (updateAccessStateResultError != null) {
      yield ErrorOutcome(updateAccessStateResultError);
      return;
    }
  }
}
