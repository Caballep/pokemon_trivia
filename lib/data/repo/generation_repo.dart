import 'package:pokemon_trivia/core/propagation/error.dart';
import 'package:pokemon_trivia/core/propagation/result.dart';
import 'package:pokemon_trivia/core/helpers/exception_handler.dart';
import 'package:pokemon_trivia/data/source/local/db/entity/generation_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';

class GenerationRepository {
  final PokemonDao _pokemonDao;
  final PokemonApi _pokemonApi;
  final ExceptionHandler _exceptionHandler;

  GenerationRepository(
      {required PokemonDao pokemonDao,
      required PokemonApi pokemonApi,
      required ExceptionHandler exceptionHandler})
      : _pokemonDao = pokemonDao,
        _pokemonApi = pokemonApi,
        _exceptionHandler = exceptionHandler;

  Future<Result<int>> getRemoteGenerationCount() async {
    try {
      final generations = await _pokemonApi.getGenerations();
      return Result.success(generations.length);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<int>> getLocalGenerationCount() async {
    try {
      final generations = await _pokemonDao.getGenerations();
      return Result.success(generations.length);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  // TODO: _pokemonApi.getGenerations() first and last are not organized by pokemon number
  // TODO2: Need to save "id" field from the API and map it to the code (roman number in db)
  Future<Result<void>> fetchGenerations() async {
    try {
      final generationsDto = await _pokemonApi.getGenerations();
      for (var generationDto in generationsDto) {
        final generationDetails =
            await _pokemonApi.getGenerationDetails(generationDto.url);
        final regionDetails =
            await _pokemonApi.getRegionDetails(generationDetails.mainRegionUrl);
        final generationEntity = GenerationEntity.from(
            generationDto, generationDetails, regionDetails);
        await _pokemonDao.insertGeneration(generationEntity);
      }
      return Result.success(null);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<GenerationModel>> getGeneration(String generationCode) async {
    try {
      final generationEntity = await _pokemonDao.getGeneration(generationCode);
      return Result.success(GenerationModel.from(generationEntity));
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<List<GenerationModel>>> getGenerations() async {
    try {
      final generationEntities = await _pokemonDao.getGenerations();
      return Result.success(GenerationModel.fromList(generationEntities));
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<void>> updateGenerationAccessState(
      String generationCode, GenerationAccessState accessState) async {
    try {
      final entityAccessState = GenerationEntityAccessState.from(accessState);

      _pokemonDao.updateGenerationPokemonsFetchedStatus(
          generationCode, entityAccessState.getIntFromGenerationAccessState());
      return Result.success(null);
    } on Exception catch (e, stackTrace) {
      RepoError error =
          _exceptionHandler.handleExceptionAndGetError(e, stackTrace);
      return Result.error(error);
    }
  }
}
