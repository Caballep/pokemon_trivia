import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/clickable_stack.dart';
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
                padding: isButtonPressed ? EdgeInsets.only(top: 8) : EdgeInsets.only(top: 3),
                child: ClickableStack(color: Colors.black87),
              ),
              Container(
                padding: isButtonPressed
                    ? EdgeInsets.only(bottom: 3, top: 8)
                    : EdgeInsets.only(bottom: 8, top: 3),
                child: ClickableStack(color: widget.color),
              ),
              Container(
                child: RetroText(
                  text: widget.text,
                  retroTextSize: RetroTextSize.huge,
                  color: Colors.white,
                ),
                padding: isButtonPressed ? EdgeInsets.only(bottom: 6) : EdgeInsets.only(bottom: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
