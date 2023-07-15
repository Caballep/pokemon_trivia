import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Will display an Image from the disk storage previously downloaded.
/// The URL it's server as the ID of the image.
class InDiskImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Color? colorize;

  const InDiskImageWidget({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.colorize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: DefaultCacheManager().getSingleFile(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return SizedBox(
            width: width,
            height: height,
            child: colorize != null
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(colorize!, BlendMode.srcATop),
                    child: Image.file(snapshot.data!),
                  )
                : Image.file(snapshot.data!),
          );
        } else {
          return SizedBox(
            width: width / 2,
            height: height / 2,
            child: Image.asset('assets/images/image-not-found.png'),
          );
        }
      },
    );
  }
}
