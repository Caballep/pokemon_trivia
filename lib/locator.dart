import 'package:device_info/device_info.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_trivia/core/utils/date_time_helper.dart';
import 'package:pokemon_trivia/core/utils/exception_handler.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/data/repo/service_privacy_repo.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_db.dart';
import 'package:pokemon_trivia/data/source/local/device/device_info_source.dart';
import 'package:pokemon_trivia/data/source/local/storage/disk_cacher.dart';
import 'package:pokemon_trivia/data/source/local/storage/shared_pref/shared_pref.dart';
import 'package:pokemon_trivia/data/source/remote/api/ipify_api.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/check_pokemons_up_to_date_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/is_tos_accepted_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/save_tos_acceptance_device_data_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_bloc.dart';
import 'package:pokemon_trivia/presentation/features/tos/tos_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Core
  locator.registerFactory(() => ExceptionHandler(Logger()));
  locator.registerFactory(() => DateTimeHelper());

  // Sources
  locator.registerSingleton(PokemonDb());
  locator.registerSingleton(PokemonApi());
  locator.registerFactory(() => DiskCacher());
  locator.registerSingleton(PokemonDao(pokemonDb: locator.get<PokemonDb>()));
  locator.registerFactory(() => IpifyApi());
  locator.registerFactory(() => DeviceInfoSource(DeviceInfoPlugin()));

  // Repositories
  locator.registerSingleton(PokemonRepository(
      pokemonApi: locator.get<PokemonApi>(),
      pokemonDao: locator.get<PokemonDao>(),
      diskCacher: locator.get<DiskCacher>(),
      exceptionHandler: locator.get<ExceptionHandler>()));
  locator.registerSingleton(ServicePrivacyRepository(
      sharedPref: SharedPref(),
      exceptionHandler: locator.get<ExceptionHandler>(),
      ipifyApi: locator.get<IpifyApi>(),
      deviceInfoSource: locator.get()));

  // UseCases
  locator.registerSingleton(
      FetchPokemonsUC(pokemonRepository: locator.get<PokemonRepository>()));
  locator.registerSingleton(CheckPokemonsUpToDateUC(
      pokemonRepository: locator.get<PokemonRepository>()));
  locator.registerSingleton(
      IsTosAcceptedUC(servicePrivacyRepository: locator.get()));
  locator.registerSingleton(SaveTosAcceptanceDeviceDataUC(
      dateTimeHelper: locator.get(), servicePrivacyRepository: locator.get()));

  // Blocs and Cubits
  locator.registerFactory(() => SplashCubit(
      fetchPokemonsUseCase: locator.get<FetchPokemonsUC>(),
      checkPokemonsUpToDateUC: locator.get<CheckPokemonsUpToDateUC>(),
      isTosAcceptedUC: locator.get()));
  locator.registerFactory(() => TosCubit(
      isTosAcceptedUC: locator.get(),
      saveTosAcceptanceDeviceDataUC: locator.get()));
}
