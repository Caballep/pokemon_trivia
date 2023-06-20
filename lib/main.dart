import 'package:flutter/material.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/menu/menu_screen.dart';
import 'package:pokemon_trivia/presentation/features/tos/tos_screen.dart';
import 'package:pokemon_trivia/test.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(home: TosScreen());
    return MaterialApp(
      home: MenuScreen(),
    );
  }
}
