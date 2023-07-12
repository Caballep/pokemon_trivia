import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/menu/widget/game_logo.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_screen.dart';
import 'package:pokemon_trivia/presentation/shared/retro_button.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class MenuScreen extends StatelessWidget {
  final height = MediaQueryUtil.height;
  final width = MediaQueryUtil.width;

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          color: Colors.amberAccent[200],
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Flexible(
                flex: 2,
                child: Row(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Flexible(flex: 8, child: GameLogo()),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                )),
            Flexible(
                flex: 5,
                child: Container(
                    padding: EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
                    height: height * 0.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: height * 0.05, right: height * 0.05),
                          width: double.infinity,
                          child: RetroButton(
                            color: Colors.red[700]!,
                            pressedColor: Colors.red[600]!,
                            height: height * 0.15,
                            text: "Play",
                            width: double.infinity,
                            iconAssetString: 'assets/images/play_icon.png',
                            onTapUp: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      Screen2(),
                                  transitionDuration: Duration(milliseconds: 150),
                                  reverseTransitionDuration: Duration(milliseconds: 150),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
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
                          height: height * 0.015,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: height * 0.05, right: height * 0.05),
                          width: double.infinity,
                          child: RetroButton(
                            color: Colors.red[500]!,
                            pressedColor: Colors.red[400]!,
                            height: height * 0.15,
                            text: "Dex",
                            width: double.infinity,
                            iconAssetString: 'assets/images/friendly_globe_icon.png',
                            onTapUp: () {},
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: height * 0.05, right: height * 0.05),
                          width: double.infinity,
                          child: RetroButton(
                            color: Colors.grey[400]!,
                            pressedColor: Colors.grey[350]!,
                            height: height * 0.15,
                            text: "About",
                            width: double.infinity,
                            iconAssetString: 'assets/images/creature_icon.png',
                            onTapUp: () {},
                          ),
                        ),
                      ],
                    )))
          ])),
    ));
  }
}
