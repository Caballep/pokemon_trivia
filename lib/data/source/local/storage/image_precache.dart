import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DiskCacher {
  Future<void> cacheImage(String imageUrl) async {
    final cacheManager = DefaultCacheManager();
    await cacheManager.downloadFile(imageUrl);
  }
}
