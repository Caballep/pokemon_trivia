import 'package:pokemon_trivia/core/propagation/error.dart';
import 'package:pokemon_trivia/core/helpers/exception_handler.dart';
import 'package:pokemon_trivia/core/propagation/result.dart';
import 'package:pokemon_trivia/data/source/local/storage/disk_cacher.dart';
import 'package:pokemon_trivia/data/source/local/db/entity/pokemon_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class PokemonRepository {
  final PokemonDao _pokemonDao;
  final PokemonApi _pokemonApi;
  final DiskCacher _diskCacher;
  final ExceptionHandler _exceptionHandler;

  PokemonRepository(
      {required PokemonDao pokemonDao,
      required PokemonApi pokemonApi,
      required DiskCacher diskCacher,
      required ExceptionHandler exceptionHandler})
      : _pokemonDao = pokemonDao,
        _pokemonApi = pokemonApi,
        _diskCacher = diskCacher,
        _exceptionHandler = exceptionHandler;

  /// It's important to mention that [PokeApi] doesn't provide a [List] of
  /// [PokemonEntity], for instance multiple calls are need to be made. This is
  /// meant to be used when the app launches, it will pull each available pokemon
  /// and sync it with the local storage.
  Future<Result<PokemonModel>> fetchPokemon(int pokemonNumber) async {
    try {
      final pokemonDto = await _pokemonApi.getPokemon(pokemonNumber);
      await _diskCacher.cacheImage(pokemonDto.frontSpriteUrl);
      final pokemonEntity = PokemonEntity.fromDto(pokemonDto);
      await _pokemonDao.insertPokemon(pokemonEntity);
      final pokemonModel = PokemonModel.fromPokemonEntity(pokemonEntity);
      return Result.success(pokemonModel);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<int>> getLocalPokemonCount() async {
    try {
      final localPokemonCount = await _pokemonDao.getPokemonsCount();
      return Result.success(localPokemonCount);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<int>> getRemotePokemonCount() async {
    try {
      final remotePokemonCount = await _pokemonApi.getPokemonCount();
      return Result.success(remotePokemonCount);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  /// Returns a [Future] that resolves to a [List] of [PokemonModel].
  Future<Result<List<PokemonModel>>> getPokemons() async {
    try {
      final pokemonEntities = await _pokemonDao.getPokemons();
      final pokemons = pokemonEntities
          .map((e) => PokemonModel.fromPokemonEntity(e))
          .toList();
      return Result.success(pokemons);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<PokemonModel>> getPokemon(int pokemonNumber) async {
    try {
      final pokemonEntity = await _pokemonDao.getPokemonByNumber(pokemonNumber);
      if (pokemonEntity != null) {
        return Result.success(PokemonModel.fromPokemonEntity(pokemonEntity));
      } else {
        throw Exception();
      }
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<List<String>>> getPokemonTypes() async {
    try {
      final pokemonTypes = await _pokemonDao.getPokemonTypes();
      return Result.success(pokemonTypes);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

}
