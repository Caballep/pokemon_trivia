import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_bloc.dart';
import 'package:pokemon_trivia/presentation/shared/cached_image.dart';
import 'package:pokemon_trivia/presentation/features/splash/loading_pokeball.dart';

class SplashScreen extends StatelessWidget {
  final SplashCubit splashCubit = locator.get<SplashCubit>();

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    splashCubit.verifyDataAndFetch();
    return Scaffold(
      body: BlocBuilder<SplashCubit, PokemonState>(
        bloc: splashCubit,
        builder: (context, state) {
          if (state is InitialState) {
            return Center(
              child: Container(),
            );
          } else if (state is NewPokemonNameState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoadingPokeball(),
                  const Text(
                    "Loading data...",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedImageWidget(
                            imageUrl: state.splashPokemon.frontSpriteUrl,
                            width: 90,
                            height: 90,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            state.splashPokemon.name,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ))
                ],
              ),
            );
          } else if (state is SplashLoadingCompleted) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Screen2()),
              );
            });
            return Container();
          } else if (state is UnknownErrorState) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pop();
            });
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

// Temporal Screen
class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Text('Welcome to Screen 2!'),
      ),
    );
  }
}
