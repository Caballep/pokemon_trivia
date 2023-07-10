import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';

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

class SplashStreamItemErrorState extends SplashState {}

class SplashUnknownErrorState extends SplashState {}
