import 'package:flutter/material.dart';

class ClickableStack extends StatelessWidget {
  final Color color;

  ClickableStack({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
            child: Container(
                width: double.infinity, height: 55, decoration: BoxDecoration(color: color))),
        Container(
            padding: const EdgeInsets.fromLTRB(10, 24, 10, 24),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: color))),
        Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: color))),
        Container(
            padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: color))),
        Container(
            padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: color))),
      ],
    );
  }
}
