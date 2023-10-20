import 'dart:convert';
import 'package:file/memory.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mocktail/mocktail.dart';

const String anyBase64String =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=';

class MockDefaultCacheManager extends Mock implements DefaultCacheManager {
  static final fileSystem = MemoryFileSystem();
  static final file = fileSystem.file('dummy.png');
  
  initFile() {
    file.createSync(recursive: true);
    file.writeAsBytesSync(base64Decode(anyBase64String));
  }

  @override
  Stream<FileResponse> getImageFile(
    String url, {
    String? key,
    int? maxWidth,
    int? maxHeight,
    Map<String, String>? headers,
    bool withProgress = false,
  }) async* {
    // during tests we will throw an error whenever the url is not an https url
    if (!url.startsWith('https://') || url == 'https://') {
      throw Exception('Invalid url');
    }
    initFile();
    yield FileInfo(
      file, // Path to the asset
      FileSource.Cache, // Simulate a cache hit
      DateTime(2050), // Very long validity
      url, // Source url
    );
  }
}
