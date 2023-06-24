import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class LoadingPokeball extends StatefulWidget {
  const LoadingPokeball({super.key});

  @override
  _LoadingPokeballState createState() => _LoadingPokeballState();
}

class _LoadingPokeballState extends State<LoadingPokeball> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            _animationController.reset();
            _animationController.forward();
          });
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 2 * 3.14159,
            child: child,
          );
        },
        child: SizedBox(
          width: 80,
          height: 80,
          child: Image.asset('assets/images/pokeball.png'),
        ),
      ),
      const SizedBox(height: 10),
      RetroText(
        text: 'Loading',
        color: Colors.black,
        fontSize: 45,
      ),
      const SizedBox(height: 10),
    ]);
  }
}
