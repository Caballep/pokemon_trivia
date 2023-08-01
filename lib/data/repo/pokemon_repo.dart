import 'package:pokemon_trivia/data/util/result.dart';
import 'package:pokemon_trivia/data/source/local/storage/disk_cacher.dart';
import 'package:pokemon_trivia/data/source/local/db/entity/pokemon_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class PokemonRepository {
  final PokemonDao _pokemonDao;
  final PokemonApi _pokemonApi;
  final DiskCacher _diskCacher;

  PokemonRepository(
      {required PokemonDao pokemonDao,
      required PokemonApi pokemonApi,
      required DiskCacher diskCacher})
      : _pokemonDao = pokemonDao,
        _pokemonApi = pokemonApi,
        _diskCacher = diskCacher;

  /// It's important to mention that [PokeApi] doesn't provide a [List] of
  /// [PokemonEntity], for instance multiple calls are need to be made. This is
  /// meant to be used when the app launches, it will pull each available pokemon
  /// and sync it with the local storage.
  Future<Result<PokemonModel>> fetchPokemon(int pokemonNumber) async {
    try {
      final pokemonDto = await _pokemonApi.getPokemon(pokemonNumber);
      final pokemonEntity = PokemonEntity.fromDto(pokemonDto);
      await _pokemonDao.insertPokemon(pokemonEntity);
      await _diskCacher.downloadAndSaveImage(pokemonDto.frontSpriteUrl, pokemonEntity.name);
      final imageFile = await _diskCacher.getImageFileFromPokemonName(pokemonEntity.name);
      final pokemonModel = PokemonModel.fromPokemonEntity(pokemonEntity, imageFile);
      return Result.success(pokemonModel);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<int>> getLocalPokemonCount() async {
    try {
      final localPokemonCount = await _pokemonDao.getPokemonsCount();
      return Result.success(localPokemonCount);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<int>> getRemotePokemonCount() async {
    try {
      final remotePokemonCount = await _pokemonApi.getPokemonCount();
      return Result.success(remotePokemonCount);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  /// Returns a [Future] that resolves to a [List] of [PokemonModel].
  Future<Result<List<PokemonModel>>> getPokemons() async {
    try {
      final pokemonEntities = await _pokemonDao.getPokemons();
      final pokemonsFuture = pokemonEntities.map((e) async {
        var imageFile = await _diskCacher.getImageFileFromPokemonName(e.name);
        return PokemonModel.fromPokemonEntity(e, imageFile);
      }).toList();
      final pokemons = await Future.wait(pokemonsFuture);
      return Result.success(pokemons);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<PokemonModel>> getPokemon(int pokemonNumber) async {
    try {
      final pokemonEntity = await _pokemonDao.getPokemonByNumber(pokemonNumber);
      if (pokemonEntity != null) {
        final imageFile = await _diskCacher.getImageFileFromPokemonName(pokemonEntity.name);
        return Result.success(PokemonModel.fromPokemonEntity(pokemonEntity, imageFile));
      } else {
        throw Exception();
      }
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }

  Future<Result<List<String>>> getPokemonTypes() async {
    try {
      final pokemonTypes = await _pokemonDao.getPokemonTypes();
      return Result.success(pokemonTypes);
    } on Exception catch (e, stackTrace) {
      return Result.error(ExceptionData(e, stackTrace));
    }
  }
}
