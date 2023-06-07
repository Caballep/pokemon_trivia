import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/splash/widget/loading_pokemon_list.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_bloc.dart';
import 'package:pokemon_trivia/presentation/features/splash/widget/loading_pokeball.dart';
import 'package:pokemon_trivia/presentation/features/splash/widget/wave_container.dart';
import 'package:pokemon_trivia/presentation/shared/basic_dialog.dart';

class SplashScreen extends StatelessWidget {
  final SplashCubit splashCubit = locator.get<SplashCubit>();

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    splashCubit.verifyDataAndFetch();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: BlocBuilder<SplashCubit, SplashState>(
          bloc: splashCubit,
          builder: (context, state) {
            if (state is SplashNetworkErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => BasicDialog(
                    icon: Icons.signal_wifi_bad,
                    iconColor: Colors.red,
                    title: 'No internet connection',
                    text:
                        'Check your WIFI/Data and make sure you have internet connection',
                    onConfirm: () {
                      SystemNavigator.pop();
                    },
                  ),
                );
              });
            }

            if (state is SplashServerErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => BasicDialog(
                    icon: Icons.cloud_off,
                    iconColor: Colors.red,
                    title: 'Unable to reach the server',
                    text:
                        'We are experiencing some issues on our end, please try again later',
                    onConfirm: () {
                      SystemNavigator.pop();
                    },
                  ),
                );
              });
            }

            if (state is SplashUnknownErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => BasicDialog(
                    icon: Icons.cancel,
                    iconColor: Colors.red,
                    title: 'Something went wrong',
                    text:
                        'If you keep experience issues please contact support',
                    onConfirm: () {
                      SystemNavigator.pop();
                    },
                  ),
                );
              });
            }

            if (state is SplashLoadingCompletedState) {
              Future.delayed(Duration.zero, () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Screen2()),
                  (route) => false,
                );
              });
            }

            return Column(
              children: [
                Flexible(
                  flex: 1,
                  child: WaveContainer(),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                if (state is SplashInitialState ||
                    state is SplashVerifyingState ||
                    state is SplashOnNextPokemonState)
                  const Flexible(
                    flex: 1,
                    child: LoadingPokeball(),
                  ),
                Flexible(
                    flex: 2,
                    child: state is SplashOnNextPokemonState
                        ? LoadingPokemonList(
                            splashPokemonList: state.splashPokemons)
                        : Container()),
              ],
            );
          },
        ),
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
