import 'package:flutter/material.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/menu/menu_screen.dart';
import 'package:pokemon_trivia/presentation/features/tos/tos_screen.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';
import 'package:pokemon_trivia/test.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
      MediaQueryUtil.height = MediaQuery.of(context).size.height;
      MediaQueryUtil.width = MediaQuery.of(context).size.width;
      // return MaterialApp(home: TosScreen());
      // Return the desired widget based on the orientation
      return MenuScreen();
    }));
  }
}
