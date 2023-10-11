import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class CoinCount extends StatelessWidget {
  final int coins; // The parameter to accept an int value.

  CoinCount(this.coins); // Constructor to accept the int value.

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 10,
                  child: Image.asset('assets/images/coin_white.png'),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleLineRetroText(
              text: coins.toString(), // Use the parameter here.
              color: Colors.amberAccent,
            ),
          ),
        ],
      ),
    );
  }
}
