import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class RetroButton extends StatefulWidget {
  final Color color;
  final Color pressedColor;
  final String text;
  final double height;
  final double width;
  final VoidCallback onTapUp;
  final String iconAssetString;

  const RetroButton(
      {Key? key,
      required this.color,
      required this.pressedColor,
      required this.text,
      required this.height,
      required this.width,
      required this.onTapUp,
      required this.iconAssetString})
      : super(key: key);

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
    final pressedTextBottomPadding = widget.height / 20;
    final textBottomPadding = widget.height / 10;
    final pressedButtonBottomPadding = widget.height / 40;
    final buttonBottomPadding = widget.height / 20;
    final iconSize = widget.height / 2;

    final textSize = widget.text.length <= 4
        ? 150.0
        : (widget.text.length <= 6)
            ? 100.0
            : (widget.text.length <= 8 ? 75.0 : 40.0);

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
                child: RetroButtonBase(color: isButtonPressed ? widget.pressedColor : widget.color),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: isButtonPressed
                          ? EdgeInsets.only(bottom: pressedButtonBottomPadding)
                          : EdgeInsets.only(bottom: buttonBottomPadding),
                      child: Container(
                          width: iconSize,
                          height: iconSize,
                          child: Image.asset(widget.iconAssetString)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: RetroText(
                        text: widget.text,
                        color: Colors.white,
                      ),
                      padding: isButtonPressed
                          ? EdgeInsets.only(bottom: pressedTextBottomPadding)
                          : EdgeInsets.only(bottom: textBottomPadding),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RetroButtonBase extends StatefulWidget {
  final Color color;

  const RetroButtonBase({Key? key, required this.color}) : super(key: key);

  @override
  _RetroButtonBaseState createState() => _RetroButtonBaseState();
}

// TODO: Rework the way this is calculated, right now is flat. Use parent Height and Width to do so.
class _RetroButtonBaseState extends State<RetroButtonBase> {
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
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: const EdgeInsets.fromLTRB(10, 24, 10, 24),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
      ],
    );
  }
}
