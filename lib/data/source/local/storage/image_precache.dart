import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/* This class provides necssary functionality to store images in the disk
 * memory of the device. It won't work on web.
 */
class DiskCacher {
  Future<void> cacheImage(String imageUrl) async {
    final cacheManager = DefaultCacheManager();
    await cacheManager.downloadFile(imageUrl);
  }
}
