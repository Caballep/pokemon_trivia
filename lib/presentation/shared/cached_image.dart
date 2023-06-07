import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Will display an Image from the disk storage previously downloaded.
/// The URL it's server as the ID of the image.
class InDiskImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const InDiskImageWidget({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: DefaultCacheManager().getSingleFile(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return SizedBox(
            width: width / 2,
            height: height / 2,
            child: Image.file(snapshot.data!),
          );
        } else {
          return SizedBox(
            width: width / 4,
            height: height / 4,
            child: Image.asset('assets/images/image-not-found.png'),
          );
        }
      },
    );
  }
}
