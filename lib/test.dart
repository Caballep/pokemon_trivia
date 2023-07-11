import 'dart:math';

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
          // Container(
          //   height: 40,
          //   child: RetroText(
          //     text: "Hola hola hola",
          //     color: Colors.red,
          //   ),
          // )
          DisappearingScreenWidget()
        ],
      ),
    );
  }
}





class DisappearingScreenWidget extends StatefulWidget {
  @override
  _DisappearingScreenWidgetState createState() => _DisappearingScreenWidgetState();
}

class _DisappearingScreenWidgetState extends State<DisappearingScreenWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DisappearingScreenPainter(animation: _animation),
      child: Container(color: Colors.black),
    );
  }
}

class _DisappearingScreenPainter extends CustomPainter {
  final Animation<double> animation;

  _DisappearingScreenPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double progress = animation.value;
    final double maxRadius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2));

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final double startRadius = progress * maxRadius;

    final int numSegments = 12;
    final double angleIncrement = 2 * pi / numSegments;

    for (int i = 0; i < numSegments; i++) {
      final double angle = angleIncrement * i;
      final double endRadius = startRadius + (progress * maxRadius * (i + 1) / numSegments);

      final path = Path()
        ..moveTo(centerX + startRadius * cos(angle), centerY + startRadius * sin(angle))
        ..lineTo(centerX + endRadius * cos(angle), centerY + endRadius * sin(angle))
        ..lineTo(centerX + endRadius * cos(angle + angleIncrement), centerY + endRadius * sin(angle + angleIncrement))
        ..lineTo(centerX + startRadius * cos(angle + angleIncrement), centerY + startRadius * sin(angle + angleIncrement))
        ..close();

      canvas.drawPath(
        path,
        Paint()..blendMode = BlendMode.clear,
      );
    }
  }

  @override
  bool shouldRepaint(_DisappearingScreenPainter oldDelegate) => false;
}
