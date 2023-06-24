import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_screen.dart';
import 'package:pokemon_trivia/presentation/shared/retro_button.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class MenuScreen extends StatelessWidget {
  final buttonsHeight = (MediaQueryUtil.height / 6.5);
  final thirdOfScreenHeight = (MediaQueryUtil.height / 3);
  final buttonsPadding = (MediaQueryUtil.width / 11);
  final spacingBetweenButtons = (MediaQueryUtil.height / 60);

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          color: const Color.fromARGB(255, 54, 45, 5),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            RetroText(text: "Pokemon", color: Colors.black),
            RetroText(text: "Quiz", color: Colors.black),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: buttonsPadding, right: buttonsPadding),
                  width: double.infinity,
                  child: RetroButton(
                    color: Colors.red[700]!,
                    pressedColor: Colors.red[600]!,
                    height: buttonsHeight,
                    text: "Play",
                    width: double.infinity,
                    iconAssetString: 'assets/images/play_icon.png',
                    onTapUp: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => Screen2(),
                          transitionDuration: Duration(milliseconds: 150),
                          reverseTransitionDuration: Duration(milliseconds: 150),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: spacingBetweenButtons,
                ),
                Container(
                  padding: EdgeInsets.only(left: buttonsPadding, right: buttonsPadding),
                  width: double.infinity,
                  child: RetroButton(
                    color: Colors.red[500]!,
                    pressedColor: Colors.red[400]!,
                    height: buttonsHeight,
                    text: "Dex",
                    width: double.infinity,
                    iconAssetString: 'assets/images/friendly_globe_icon.png',
                    onTapUp: () {},
                  ),
                ),
                SizedBox(
                  height: spacingBetweenButtons,
                ),
                Container(
                  padding: EdgeInsets.only(left: buttonsPadding, right: buttonsPadding),
                  width: double.infinity,
                  child: RetroButton(
                    color: Colors.grey[400]!,
                    pressedColor: Colors.grey[300]!,
                    height: buttonsHeight,
                    text: "About",
                    width: double.infinity,
                    iconAssetString: 'assets/images/creature_icon.png',
                    onTapUp: () {},
                  ),
                ),
              ],
            )
          ])),
    ));
  }
}
