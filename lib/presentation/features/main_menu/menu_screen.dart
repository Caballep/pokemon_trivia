import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/about/about_screen.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_screen.dart';
import 'package:pokemon_trivia/presentation/features/main_menu/widget/game_logo.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_screen.dart';
import 'package:pokemon_trivia/presentation/shared/retro_button.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class MainMenuScreen extends StatelessWidget {
  final height = MediaQueryUtil.height;
  final width = MediaQueryUtil.width;

  MainMenuScreen({super.key});

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
                            iconAssetString: 'assets/images/play.png',
                            onTapUp: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      RegionsMenuScreen(),
                                  transitionDuration: const Duration(milliseconds: 150),
                                  reverseTransitionDuration: const Duration(milliseconds: 150),
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
                            iconAssetString: 'assets/images/dex.png',
                            onTapUp: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      DexScreen(),
                                  transitionDuration: const Duration(milliseconds: 150),
                                  reverseTransitionDuration: const Duration(milliseconds: 150),
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
                            color: Colors.grey[400]!,
                            pressedColor: Colors.grey[350]!,
                            height: height * 0.15,
                            text: "About",
                            width: double.infinity,
                            iconAssetString: 'assets/images/about.png',
                            onTapUp: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      AboutScreen(),
                                  transitionDuration: const Duration(milliseconds: 150),
                                  reverseTransitionDuration: const Duration(milliseconds: 150),
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
                      ],
                    )))
          ])),
    ));
  }
}
