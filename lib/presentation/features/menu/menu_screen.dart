import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_button.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(40),
            width: double.infinity,
            color: Colors.white,
            child: RetroButton(
              color: Colors.red,
              height: 120,
              text: "Play",
              width: double.infinity,
              onTapUp: () {},
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 120,
              maxHeight: 180,
            ),
            width: double.infinity,
            color: Colors.blue,
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 120,
              maxHeight: 180,
            ),
            width: double.infinity,
            color: Colors.green,
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 120,
              maxHeight: 180,
            ),
            width: double.infinity,
            color: Colors.yellow,
          ),
        ],
      )),
    );
  }
}
