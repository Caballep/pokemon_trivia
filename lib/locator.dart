import 'package:device_info/device_info.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_trivia/core/helpers/date_time_helper.dart';
import 'package:pokemon_trivia/domain/helper/exception_handler.dart';
import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/data/repo/service_privacy_repo.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_db.dart';
import 'package:pokemon_trivia/data/source/local/device/device_info_source.dart';
import 'package:pokemon_trivia/data/source/local/storage/disk_cacher.dart';
import 'package:pokemon_trivia/data/source/local/storage/shared_pref/shared_pref.dart';
import 'package:pokemon_trivia/data/source/remote/api/ipify_api.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_app_initial_data.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_generations_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_generations_uc.dart';
import 'package:pokemon_trivia/domain/use_case/tos/is_tos_accepted_uc.dart';
import 'package:pokemon_trivia/domain/use_case/tos/save_tos_acceptance_device_data_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_bloc.dart';
import 'package:pokemon_trivia/presentation/features/tos/tos_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Project Core
  locator.registerFactory(() => DateTimeHelper());

  // Sources
  locator.registerSingleton(PokemonDb());
  locator.registerSingleton(PokemonApi());
  locator.registerFactory(() => DiskCacher());
  locator.registerSingleton(PokemonDao(pokemonDb: locator.get()));
  locator.registerFactory(() => IpifyApi());
  locator.registerFactory(() => DeviceInfoSource(DeviceInfoPlugin()));

  // Repositories
  locator.registerSingleton(PokemonRepository(
      pokemonApi: locator.get(), pokemonDao: locator.get(), diskCacher: locator.get()));
  locator.registerSingleton(ServicePrivacyRepository(
      sharedPref: SharedPref(), ipifyApi: locator.get(), deviceInfoSource: locator.get()));
  locator.registerSingleton(
      GenerationRepository(pokemonDao: locator.get(), pokemonApi: locator.get()));

  // Domain Core
  locator.registerFactory(() => ExceptionHandler(Logger()));

  // Domain UseCases
  locator.registerSingleton(FetchPokemonsUC(
      pokemonRepository: locator.get(),
      generationRepository: locator.get(),
      exceptionHandler: locator.get()));
  locator.registerSingleton(IsTosAcceptedUC(servicePrivacyRepository: locator.get()));
  locator.registerSingleton(SaveTosAcceptanceDeviceDataUC(
      dateTimeHelper: locator.get(), servicePrivacyRepository: locator.get()));
  locator.registerSingleton(
      GetGenerationsUC(generationRepository: locator.get(), exceptionHandler: locator.get()));
  locator.registerFactory(() =>
      FetchGenerationsUC(generationRepository: locator.get(), exceptionHandler: locator.get()));
  locator.registerFactory(() => FetchInitialDataAndGetPokemonsUC(
      fetchGenerationsUC: locator.get(),
      fetchPokemonsInRangeUC: locator.get(),
      getGenerationsUC: locator.get()));

  // Blocs and Cubits
  locator.registerFactory(() => SplashCubit(fetchInitialDataAndGetPokemonsUC: locator.get()));
  locator.registerFactory(
      () => TosCubit(isTosAcceptedUC: locator.get(), saveTosAcceptanceDeviceDataUC: locator.get()));
}
