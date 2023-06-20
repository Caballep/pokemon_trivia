import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_button.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class MenuScreen extends StatelessWidget {
  final buttonsHeight = (MediaQueryUtil.height / 6);
  final thirdOfScreenHeight = (MediaQueryUtil.height / 3);
  final buttonsPadding = 35.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          color: Colors.amberAccent,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            RetroText(text: "Poke", retroTextSize: RetroTextSize.gigantic, color: Colors.black),
            RetroText(text: "Trivia", retroTextSize: RetroTextSize.huge, color: Colors.black),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: buttonsPadding, right: buttonsPadding),
                  width: double.infinity,
                  child: RetroButton(
                    color: Colors.red,
                    height: buttonsHeight,
                    text: "Play",
                    width: double.infinity,
                    onTapUp: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: buttonsPadding, right: buttonsPadding),
                  width: double.infinity,
                  child: RetroButton(
                    color: Colors.red,
                    height: buttonsHeight,
                    text: "Dex",
                    width: double.infinity,
                    onTapUp: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: buttonsPadding, right: buttonsPadding),
                  width: double.infinity,
                  child: RetroButton(
                    color: Colors.red,
                    height: buttonsHeight,
                    text: "About",
                    width: double.infinity,
                    onTapUp: () {},
                  ),
                ),
              ],
            )
          ])),
    ));
  }
}
