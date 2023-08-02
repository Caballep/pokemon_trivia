import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MultiLineRetroText(
            text: 'Made with Love in Flutter for Android and iOS by Caballep.',
            color: Colors.black,
            fontSize: 28,
          ),
          const SizedBox(height: 20),
          const Text(
            'Credits',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          MultiLineRetroText(
            text: 'Pokemon data and images:\npokeapi.co',
            color: Colors.black,
            fontSize: 18,
          ),
          const SizedBox(height: 10),
          MultiLineRetroText(
            text: 'Visual resources:\nxxxxx\nxxxxx\nxxxxx',
            color: Colors.black,
            fontSize: 18,
          ),
          const SizedBox(height: 10),
          MultiLineRetroText(
            text: 'Music:\nxxxxx\nxxxxx\nxxxxx',
            color: Colors.black,
            fontSize: 18,
          ),
        ],
      ),
    ));
  }
}
