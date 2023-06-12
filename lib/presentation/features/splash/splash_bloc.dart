import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/is_tos_accepted_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';
import 'package:pokemon_trivia/core/propagation/error.dart';

class SplashCubit extends Cubit<SplashState> {
  final FetchPokemonsUC _fetchPokemonsUseCase;
  late List<SplashPokemon> _splashPokemonList;

  SplashCubit({
    required FetchPokemonsUC fetchPokemonsUseCase,
    required IsTosAcceptedUC isTosAcceptedUC,
  })  : _fetchPokemonsUseCase = fetchPokemonsUseCase,
        super(SplashInitialState()) {
    _splashPokemonList = List.empty(growable: true);
  }

  Future<void> fetchPokemonData() async {
    await for (final pokemonModelResult in _fetchPokemonsUseCase.invoke()) {
      if (pokemonModelResult.isSuccess) {
        final pokemonModel = pokemonModelResult.data;
        if (pokemonModel != null) {
          _updateSplashPokemonList(
              SplashPokemon.fromPokemonModel(pokemonModel));
          emit(SplashOnNextPokemonState(_splashPokemonList));
        } else {
          // Null Pokemon, not a breaking flow, ignore
        }
      } else {
        _handleError(pokemonModelResult.error);
        return;
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

  void _handleError(RepoError? error) {
    if (error == RepoError.noInternet || error == RepoError.genericNetwork) {
      emit(SplashNetworkErrorState());
      return;
    }
    if (error == RepoError.timeOut || error == RepoError.serverIssue) {
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
