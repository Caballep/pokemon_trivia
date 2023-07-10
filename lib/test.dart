import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

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
          Container(
            height: 40,
            child: RetroText(
              text: "Hola hola hola",
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
