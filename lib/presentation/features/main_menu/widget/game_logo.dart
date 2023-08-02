import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class GameLogo extends StatelessWidget {
  const GameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: SingleLineRetroText(text: "Poke Master", color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 5, right: 5),
                child: SingleLineRetroText(text: "Poke Master", color: Colors.white),
              )
            ],
          ),
        ),
        Flexible(flex: 1, child: RetroText(text: "QUIZ", color: Colors.black))
      ],
    );
  }
}



            // Container(
            //     height: height * 0.30,
            //     padding:
            //         EdgeInsets.only(left: height * 0.05, right: height * 0.05, top: height * 0.05),
            //     child: Stack(alignment: Alignment.center, children: [
            //       Container(
            //         padding: EdgeInsets.only(
            //             top: height * 0.015, left: height * 0.005, bottom: height * 0.1),
            //         child: RetroText(text: "Pokemon", color: Colors.black),
            //       ),
            //       Container(
            //         padding: EdgeInsets.only(
            //             top: height * 0.001, right: height * 0.005, bottom: height * 0.1),
            //         child: RetroText(text: "Pokemon", color: Colors.white),
            //       ),
            //       Container(
            //         padding: EdgeInsets.only(
            //             top: height * 0.11, left: height * 0.2, bottom: height * 0.05),
            //         child: RetroText(text: "Trivia", color: Colors.black),
            //       ),
            //     ])),