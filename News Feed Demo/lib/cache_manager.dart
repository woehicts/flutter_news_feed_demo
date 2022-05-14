import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as cache_management;
import 'package:http/http.dart' as http;

/// Stores the editorial images of the articles on the local file system.
class CacheManager {
  /// Cache storage key, that uniquely identifies a database for the storage manager.
  static const String _cacheManagerKey = 'customCacheKey';

  /// Only a single instance of 'flutter\_cache\_manager' should work at the time
  static final instance = cache_management.CacheManager.custom(
      cache_management.Config(
        _cacheManagerKey,
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 500,
        repo: cache_management.JsonCacheInfoRepository(databaseName: _cacheManagerKey),
        fileService: cache_management.HttpFileService(),
      )
  );

  /// Downloads an image using the provided [imageURL] address,
  /// unless an image with the same URL address is already stored by the cache manager.
  static Future<FileImage?> fetchImage(String imageURL) async{
    Uri? url = Uri.tryParse(imageURL);
    if (url != null) {
      try {
        var imageFile = await instance.getSingleFile(imageURL);
        return FileImage(imageFile);
      }catch(e){
        // failed to load an image for various reasons
      }
    }
  }

  /// Requests news feed directly from a server,
  /// since a stack of the latest news is non-cacheable
  static Future<Map<String,dynamic>> requestFeed(String requestURL) async{
    var jsonFile = await instance.getSingleFile(requestURL);
    Uri? url = Uri.tryParse(requestURL);
    if (url != null) {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    }
    return <String,dynamic>{};

  }
}