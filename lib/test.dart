import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_button.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RetroButton(
            color: Colors.red,
            text: "Click",
            height: 120,
            width: double.infinity,
            onTapUp: () {},
          ),
          // RetroButton(),
          // RetroButton(),
        ],
      ),
    );
  }
}
