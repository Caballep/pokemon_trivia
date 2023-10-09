import 'package:device_info/device_info.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_trivia/core/helpers/date_time_helper.dart';
import 'package:pokemon_trivia/data/repo/game_repo.dart';
import 'package:pokemon_trivia/data/source/local/db/game_dao.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/data/repo/service_privacy_repo.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_trivia_db.dart';
import 'package:pokemon_trivia/data/source/local/device/device_info_source.dart';
import 'package:pokemon_trivia/data/source/local/storage/disk_cacher.dart';
import 'package:pokemon_trivia/data/source/local/storage/shared_pref/shared_pref.dart';
import 'package:pokemon_trivia/data/source/remote/api/ipify_api.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/use_case/game/add_coins_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_coins_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_region_option_detail_model_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_region_score_model_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/get_regions_and_score_model_uc.dart';
import 'package:pokemon_trivia/domain/use_case/game/unlock_region.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_app_initial_data_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_generations_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_detailed_pokemons.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generation_iconic_pokemons_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generation_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generations_uc.dart';
import 'package:pokemon_trivia/domain/use_case/tos/is_tos_accepted_uc.dart';
import 'package:pokemon_trivia/domain/use_case/tos/save_tos_acceptance_device_data_uc.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/coin/coin_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_cubit.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_bloc.dart';
import 'package:pokemon_trivia/presentation/features/tos/tos_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Project Core
  locator.registerFactory(() => DateTimeHelper());

  // Sources
  locator.registerSingleton(PokemonTriviaDb());
  locator.registerSingleton(PokemonApi());
  locator.registerFactory(() => DiskCacher());
  locator.registerSingleton(PokemonDao(pokemonTriviaDb: locator.get()));
  locator.registerFactory(() => IpifyApi());
  locator.registerFactory(() => DeviceInfoSource(DeviceInfoPlugin()));
  locator.registerSingleton(GameDao(pokemonTriviaDb: locator.get()));

  // Repositories
  locator.registerSingleton(PokemonRepository(
      pokemonApi: locator.get(), pokemonDao: locator.get(), diskCacher: locator.get()));
  locator.registerSingleton(ServicePrivacyRepository(
      sharedPref: SharedPref(), ipifyApi: locator.get(), deviceInfoSource: locator.get()));
  locator.registerSingleton(
      GenerationRepository(pokemonDao: locator.get(), pokemonApi: locator.get()));
  locator.registerSingleton(GameRepository(gameDao: locator.get()));

  // Domain Core
  locator.registerFactory(() => ResultHandler(Logger()));

  // Domain UseCases
  locator.registerSingleton(FetchPokemonsUC(
      pokemonRepository: locator.get(),
      generationRepository: locator.get(),
      resultHandler: locator.get()));
  locator.registerSingleton(IsTosAcceptedUC(servicePrivacyRepository: locator.get()));
  locator.registerSingleton(SaveTosAcceptanceDeviceDataUC(
      dateTimeHelper: locator.get(), servicePrivacyRepository: locator.get()));
  locator.registerSingleton(
      GetGenerationsUC(generationRepository: locator.get(), resultHandler: locator.get()));
  locator.registerFactory(
      () => FetchGenerationsUC(generationRepository: locator.get(), resultHandler: locator.get()));
  locator.registerFactory(() => FetchInitialDataAndGetPokemonsUC(
      fetchGenerationsUC: locator.get(),
      fetchPokemonsInRangeUC: locator.get(),
      getGenerationsUC: locator.get()));
  locator.registerFactory(() => GetDetailedPokemonsUC(locator.get(), locator.get(), locator.get()));
  locator.registerFactory(
      () => AddCoinsUC(resultHandler: locator.get(), gameRepository: locator.get()));
  locator.registerFactory(
      () => GetCoinsUC(resultHandler: locator.get(), gameRepository: locator.get()));
  locator.registerFactory(() => GetRegionsAndScoresModelUC(
      gameRepository: locator.get(),
      resultHandler: locator.get(),
      generationRepository: locator.get()));
  locator.registerFactory(() => GetThreeIconicPokemonImagesUC(
      pokemonRepository: locator.get(),
      generationRepository: locator.get(),
      resultHandler: locator.get()));
  locator.registerFactory(() => GetGenerationScoreUC(
      gameRepository: locator.get(),
      generationRepository: locator.get(),
      resultHandler: locator.get()));
  locator.registerFactory(
      () => GetGenerationUC(generationRepository: locator.get(), resultHandler: locator.get()));
  locator.registerFactory(() => GetRegionOptionDetailModelUC(
      getGenerationScoreUC: locator.get(),
      getGenerationUC: locator.get(),
      getGenerationsUC: locator.get(),
      getThreeIconicPokemonImagesUC: locator.get()));
  locator.registerFactory(() => UnlockRegionUC(
      generationRepository: locator.get(),
      resultHandler: locator.get(),
      gameRepository: locator.get()));

  // Blocs and Cubits
  locator.registerFactory(() =>
      SplashCubit(fetchInitialDataAndGetPokemonsUC: locator.get(), fetchPokemonsUC: locator.get()));
  locator.registerFactory(
      () => TosCubit(isTosAcceptedUC: locator.get(), saveTosAcceptanceDeviceDataUC: locator.get()));
  locator.registerFactory(() => DexCubit(getAllPokemonsUC: locator.get()));
  locator.registerFactory(() => RegionMenuCubit(
      getRegionsAndScoresModelUC: locator.get()));
  locator.registerFactory(() => RegionOptionCubit(
      getRegionOptionDetailModelUC: locator.get(), unlockRegionUC: locator.get()));
  locator.registerSingleton(CoinCubit(addCoinsUC: locator.get(), getCoinsUC: locator.get()));
}
