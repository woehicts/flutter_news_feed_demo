import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

/// Loads newsapi.org request parameters from the asset file.
Future<Map<String,dynamic>> loadConfig() async{
  var configData = await rootBundle.loadString('assets/request.config.json');
  return jsonDecode(configData);
}