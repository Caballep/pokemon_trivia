import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/domain/helper/exception_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class FetchPokemonsUC {
  final PokemonRepository _pokemonRepository;
  final GenerationRepository _generationRepository;
  final ExceptionHandler _exceptionHandler;

  FetchPokemonsUC(
      {required PokemonRepository pokemonRepository,
      required GenerationRepository generationRepository,
      required ExceptionHandler exceptionHandler})
      : _pokemonRepository = pokemonRepository,
        _generationRepository = generationRepository,
        _exceptionHandler = exceptionHandler;

  /// This function will only try to fetch Pokemons only if there is new Pokemon
  /// available in the remote.
  Stream<Outcome<PokemonModel?>> invoke(String generationCode) async* {
    final generationResult = await _generationRepository.getGeneration(generationCode);

    if (generationResult.isError) {
      final error = _exceptionHandler.handleAndGetError(generationResult.exceptionData!);
      yield ErrorOutcome(error);
      return;
    }

    if (generationResult.data == null) {
      yield ErrorOutcome(Errors.nullOrEmptyUnexpectedData);
      return;
    }

    final firstPokemon = generationResult.data!.startsWith;
    final lastPokemon = generationResult.data!.endsWith;

    // for (int i = firstPokemon; i <= lastPokemon + 1; i++) { TODO
    for (int i = firstPokemon; i <= 25 + 1; i++) {
      final pokemon = await _pokemonRepository.fetchPokemon(i);
      if (pokemon.isError) {
        yield ErrorOutcome(Errors.nullItem);
      } else {
        yield SuccessOutcome(pokemon.data);
      }
    }

    final updateAccessStateResult = await _generationRepository.updateGenerationAccessState(
        generationResult.data!.code, GenerationAccessState.pokemonsFetched);

    if (updateAccessStateResult.isError) {
      final error = _exceptionHandler.handleAndGetError(updateAccessStateResult.exceptionData!);
      yield ErrorOutcome(error);
    }
  }
}
