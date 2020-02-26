import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class CustomCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static CustomCacheManager _instance;

  factory CustomCacheManager() {
    if (_instance == null) {
      _instance = new CustomCacheManager._();
    }
    return _instance;
  }

  CustomCacheManager._() : super(key,
      maxAgeCacheObject: Duration(days: 360),
      maxNrOfCacheObjects: 999,
      fileFetcher: _customHttpGetter);


  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return "${directory.path}/$key";
  }

  static Future<FileFetcherResponse> _customHttpGetter(String url, {Map<String, String> headers}) async {
    return HttpFileFetcherResponse(await http.get(url, headers: headers));
  }
}