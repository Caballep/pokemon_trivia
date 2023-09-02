import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/main_menu/menu_screen.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_states.dart';
import 'package:pokemon_trivia/presentation/features/splash/widget/loading_pokemon_list.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_bloc.dart';
import 'package:pokemon_trivia/presentation/features/splash/widget/loading_pokeball.dart';
import 'package:pokemon_trivia/presentation/shared/basic_dialog.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class SplashScreen extends StatelessWidget {
  final SplashCubit splashCubit = locator.get<SplashCubit>();
  final height = MediaQueryUtil.height;

  SplashScreen({Key? key}) : super(key: key) {
    splashCubit.fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
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
                    text: 'Check your WIFI/Data and make sure you have internet connection',
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
                    text: 'We are experiencing some issues on our end, please try again later',
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
                    text: 'If you keep experience issues please contact support',
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
                  MaterialPageRoute(builder: (context) => MainMenuScreen()),
                  (route) => false,
                );
              });
            }

            return Column(
              children: [
                const Spacer(flex: 9),
                if (state is SplashInitialState ||
                    state is SplashVerifyingState ||
                    state is SplashOnNextPokemonState)
                  const Flexible(
                    flex: 4,
                    child: LoadingPokeball(),
                  ),
                const Spacer(flex: 1),
                Flexible(
                    flex: 6,
                    child: state is SplashOnNextPokemonState
                        ? LoadingPokemonList(splashPokemonList: state.splashPokemons)
                        : Container()),
                const Spacer(flex: 3)
              ],
            );
          },
        ),
      ),
    );
  }
}
