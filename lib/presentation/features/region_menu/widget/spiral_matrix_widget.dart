import 'dart:async';
import 'package:flutter/material.dart';

class SpiralMatrixWidget extends StatefulWidget {
  final Function? onAnimationCompleted;

  SpiralMatrixWidget({Key? key, this.onAnimationCompleted}) : super(key: key);

  @override
  _SpiralMatrixWidgetState createState() => _SpiralMatrixWidgetState();
}

class _SpiralMatrixWidgetState extends State<SpiralMatrixWidget> {
  final int rows = 15;
  final int columns = 8;
  List<List<Color>> matrixColors = List.empty();
  int currentX = 0;
  int currentY = 0;
  int maxX = 7;
  int maxY = 14;
  int minX = 0;
  int minY = 0;

  @override
  void initState() {
    super.initState();
    matrixColors = List.generate(rows, (_) => List.filled(columns, Colors.black));
    _startSpiralAnimation();
  }

  Future<void> _startSpiralAnimation() async {
    matrixColors[0][0] = Colors.white;
    while (minX <= maxX && minY <= maxY) {
      await Future.delayed(const Duration(milliseconds: 10));
      setState(() {
        if (currentY == minY && currentX < maxX) {
          currentX++;
        } else if (currentX == maxX && currentY < maxY) {
          currentY++;
        } else if (currentY == maxY && currentX > minX) {
          currentX--;
        } else if (currentX == minX && currentY > minY) {
          currentY--;
          if (currentY == minY + 1) {
            minX++;
            minY++;
            maxX--;
            maxY--;
          }
        }

        matrixColors[currentY][currentX] = Colors.white;
      });
    }

    // Animation is completed, call the callback
    if (widget.onAnimationCompleted != null) {
      widget.onAnimationCompleted!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cellWidth = screenWidth / columns;
    final cellHeight = screenHeight / rows;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(rows, (y) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(columns, (x) {
                return Container(
                  width: cellWidth,
                  height: cellHeight,
                  color: matrixColors[y][x],
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
