import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class RetroButton extends StatefulWidget {
  final Color color;
  final String text;
  final double height;
  final double width;
  final VoidCallback onTapUp;

  const RetroButton({
    Key? key,
    required this.color,
    required this.text,
    required this.height,
    required this.width,
    required this.onTapUp,
  }) : super(key: key);

  @override
  _RetroButtonState createState() => _RetroButtonState();
}

class _RetroButtonState extends State<RetroButton> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    final topPadding = widget.height / 40;
    final bottomPadding = widget.height / 15;
    final pressedTopPadding = widget.height / 15;
    final pressedBottomPadding = widget.height / 40;
    final textBottomPadding = widget.height / 20;
    final pressedTextBottomPadding = widget.height / 10;

    return Center(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isButtonPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            isButtonPressed = false;
          });
          widget.onTapUp(); // Notify the parent widget about the onTapUp event
        },
        onTapCancel: () {
          setState(() {
            isButtonPressed = false;
          });
        },
        child: Container(
          height: widget.height,
          width: widget.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: isButtonPressed
                    ? EdgeInsets.only(top: topPadding)
                    : EdgeInsets.only(top: bottomPadding),
                child: RetroButtonBase(color: Colors.black87),
              ),
              Container(
                padding: isButtonPressed
                    ? EdgeInsets.only(bottom: pressedBottomPadding, top: pressedTopPadding)
                    : EdgeInsets.only(bottom: bottomPadding, top: topPadding),
                child: RetroButtonBase(color: widget.color),
              ),
              Container(
                child: RetroText(
                  text: widget.text,
                  retroTextSize: RetroTextSize.huge,
                  color: Colors.white,
                ),
                padding: isButtonPressed
                    ? EdgeInsets.only(bottom: textBottomPadding)
                    : EdgeInsets.only(bottom: pressedTextBottomPadding),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Rework the way this is calculated, right now is flat. Use parent Height and Width to do so.
class RetroButtonBase extends StatelessWidget {
  final Color color;

  RetroButtonBase({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 36, 0, 36),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: color))),
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
