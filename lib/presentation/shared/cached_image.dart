import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultCacheManager().getSingleFile(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Container(
              width: width,
              height: height,
              child: Image.file(snapshot.data as File),
            );
          } else {
            return SizedBox(
              width: width / 2,
              height: height / 2,
              child: Image.asset('assets/images/image-not-found.png'),
            );
          }
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
