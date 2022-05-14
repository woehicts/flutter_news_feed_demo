import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:top_news_headlines/utilities.dart';

/// newsapi.org news feed GET request string builder
class RequestString {
  /// A map containing config data for newsapi.org requests
  late final Future<Map<String,dynamic>> requestConfig;

  RequestString(){
    requestConfig = _loadAsset();
  }

  /// Loads request configuration data from assets file
  Future<Map<String,dynamic>> _loadAsset() async {
    return await jsonDecode(await rootBundle.loadString('assets/request.config.json'));
  }

  /// Builds newsapi.org GET request string,
  /// provided that the asset data is loaded
  Future<String> build(int page) async{
    var config = await requestConfig;
    var now = DateTime.now();
    String from = getISODateString(now);
    return "https://newsapi.org/v2/everything?"
        "q=${config['SearchKeyword']}"
        "&from=$from"
        "&page=$page"
        "&sortBy=publishedAt"
        "&apiKey=${config['apiKey']}";
  }
}