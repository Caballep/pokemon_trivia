import 'dart:io';

import 'package:flutter/material.dart';

/// Will display an Image from the disk storage previously downloaded.
/// The URL it's server as the ID of the image.
class InDiskImageWidget extends StatelessWidget {
  final File imageFile;
  final double height;
  final double width;
  final Color? colorize;

  const InDiskImageWidget({
    Key? key,
    required this.imageFile,
    required this.height,
    required this.width,
    this.colorize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: colorize != null
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(colorize!, BlendMode.srcATop),
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              )
            : Image.file(
                imageFile,
                fit: BoxFit.cover,
              ));
  }
}
