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
    final topPadding = widget.height * 0.025;
    final bottomPadding = widget.height * 0.065;
    final pressedTopPadding = widget.height * 0.065;
    final pressedBottomPadding = widget.height * 0.025;
    final pressedTextBottomPadding = widget.height * 0.05;
    final textBottomPadding = widget.height * 0.1;
    final pressedButtonBottomPadding = widget.height * 0.025;
    final buttonBottomPadding = widget.height * 0.05;
    final pressedButtonPaddingIcon = widget.height * 0.025;
    final buttonPaddingIcon = widget.height * 0.05;
    final iconSize = widget.height * 0.5;
    final textLeftPadding = widget.height * 0.1;
    final textRightPadding = widget.height * 0.25;

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
          widget.onTapUp();
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
                child: RetroButtonBase(
                  color: Colors.black87,
                  height: widget.height,
                ),
              ),
              Container(
                padding: isButtonPressed
                    ? EdgeInsets.only(bottom: pressedBottomPadding, top: pressedTopPadding)
                    : EdgeInsets.only(bottom: bottomPadding, top: topPadding),
                child: RetroButtonBase(
                    color: isButtonPressed ? widget.pressedColor : widget.color,
                    height: widget.height),
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
                          padding: isButtonPressed
                              ? EdgeInsets.only(
                                  top: buttonPaddingIcon, bottom: pressedButtonPaddingIcon)
                              : EdgeInsets.only(
                                  top: pressedButtonPaddingIcon, bottom: buttonPaddingIcon),
                          child: Image.asset(widget.iconAssetString)),
                    ),
                  ),
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
                        padding: EdgeInsets.only(
                            bottom: isButtonPressed ? pressedTextBottomPadding : textBottomPadding,
                            right: textRightPadding,
                            left: textLeftPadding)),
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
  final double height;

  const RetroButtonBase({
    Key? key,
    required this.color,
    required this.height,
  }) : super(key: key);

  @override
  _RetroButtonBaseState createState() => _RetroButtonBaseState();
}

class _RetroButtonBaseState extends State<RetroButtonBase> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(0, widget.height * 0.3, 0, widget.height * 0.3),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: EdgeInsets.fromLTRB(
                widget.height * 0.1, widget.height * 0.2, widget.height * 0.1, widget.height * 0.2),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: EdgeInsets.fromLTRB(
                widget.height * 0.2, widget.height * 0.1, widget.height * 0.2, widget.height * 0.1),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: EdgeInsets.fromLTRB(
                widget.height * 0.3, widget.height * 0.1, widget.height * 0.3, widget.height * 0.1),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
        Container(
            padding: EdgeInsets.fromLTRB(widget.height * 0.4, 0, widget.height * 0.4, 0),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: widget.color))),
      ],
    );
  }
}
