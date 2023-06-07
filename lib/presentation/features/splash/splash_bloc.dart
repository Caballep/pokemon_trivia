import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/check_pokemons_up_to_date_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';
import 'package:pokemon_trivia/core/propagation/error.dart';

class SplashCubit extends Cubit<SplashState> {
  final FetchPokemonsUseCase _fetchPokemonsUseCase;
  final CheckPokemonsUpToDateUC _checkPokemonsUpToDateUC;
  late List<SplashPokemon> _splashPokemonList;

  Logger logger = Logger();
  SplashCubit({
    required FetchPokemonsUseCase fetchPokemonsUseCase,
    required CheckPokemonsUpToDateUC checkPokemonsUpToDateUC,
  })  : _fetchPokemonsUseCase = fetchPokemonsUseCase,
        _checkPokemonsUpToDateUC = checkPokemonsUpToDateUC,
        super(SplashInitialState()) {
    _splashPokemonList = List.empty(growable: true);
  }

  Future<void> verifyDataAndFetch() async {
    logger.d("verifyDataAndFetch()");
    emit(SplashVerifyingState());
    final isPokemonsUpToDate = await _checkPokemonsUpToDateUC.invoke();
    if (isPokemonsUpToDate.isSuccess) {
      logger.d("isPokemonsUpToDate isSuccess");
      if (isPokemonsUpToDate.data == true) {
        logger.d("isPokemonsUpToDate.data == true");
        emit(SplashLoadingCompletedState());
        return;
      }
      fetchPokemonData();
    } else {
      logger.d("isPokemonsUpToDate onError");
      _handleError(isPokemonsUpToDate.error);
    }
  }

  Future<void> fetchPokemonData() async {
    await for (final pokemonModelResult in _fetchPokemonsUseCase.invoke()) {
      if (pokemonModelResult.isSuccess) {
        final pokemonModel = pokemonModelResult.data;
        if (pokemonModel != null) {
          _updateSplashPokemonList(
              SplashPokemon.fromPokemonModel(pokemonModel));
          emit(SplashOnNextPokemonState(_splashPokemonList));
        }
      } else {
        _handleError(pokemonModelResult.error);
      }
    }
    emit(SplashLoadingCompletedState());
  }

  void _updateSplashPokemonList(SplashPokemon splashPokemon) {
    if (_splashPokemonList.length >= 5) {
      _splashPokemonList.removeLast();
    }
    _splashPokemonList.insert(0, splashPokemon);
  }

  void _handleError(Error? error) {
    if (error == Error.noInternet || error == Error.genericNetwork) {
      emit(SplashNetworkErrorState());
      return;
    }
    if (error == Error.timeOut || error == Error.serverIssue) {
      emit(SplashServerErrorState());
      return;
    }
    emit(SplashUnknownErrorState());
  }
}

abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashOnNextPokemonState extends SplashState {
  final List<SplashPokemon> splashPokemons;

  SplashOnNextPokemonState(this.splashPokemons);
}

class SplashVerifyingState extends SplashState {}

class SplashLoadingCompletedState extends SplashState {}

class SplashNetworkErrorState extends SplashState {}

class SplashServerErrorState extends SplashState {}

class SplashUnknownErrorState extends SplashState {}
