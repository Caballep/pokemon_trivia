import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/cached_image.dart';

class ImageSticker extends StatelessWidget {
  final File imageFile;
  final double size;
  const ImageSticker({Key? key, required this.imageFile, required this.size});

  @override
  Widget build(BuildContext context) {
    final paddingA = size * 0.025;
    final paddingB = size * 0.038;
    final sizeB = size * 0.81;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            padding: EdgeInsets.only(top: paddingA, left: paddingA),
            child: InDiskImageWidget(
              colorize: Colors.black,
              width: size,
              height: size,
              imageFile: imageFile,
            )),
        Container(
            padding: EdgeInsets.only(bottom: paddingA, right: paddingA),
            child: InDiskImageWidget(
              colorize: Colors.white,
              width: size,
              height: size,
              imageFile: imageFile,
            )),
        Container(
            padding: EdgeInsets.only(bottom: paddingB, right: paddingB),
            child: InDiskImageWidget(
              width: sizeB,
              height: sizeB,
              imageFile: imageFile,
            )),
      ],
    );
  }
}

class ChangingImageSticker extends StatefulWidget {
  final List<File> displayPokemonImageFiles;
  final double size;

  ChangingImageSticker({required this.displayPokemonImageFiles, required this.size});

  @override
  _ChangingImageStickerState createState() => _ChangingImageStickerState();
}

class _ChangingImageStickerState extends State<ChangingImageSticker> {
  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), _changeImage);
  }

  void _changeImage(Timer timer) {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.displayPokemonImageFiles.length;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImageSticker(
      imageFile: widget.displayPokemonImageFiles[currentIndex],
      size: widget.size,
    );
  }
}
