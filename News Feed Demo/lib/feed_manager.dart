import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:top_news_headlines/feed_item.dart';
import 'package:top_news_headlines/request_string.dart';
import 'cache_manager.dart';

part 'feed_manager.g.dart';

class FeedManager = _FeedManager with _$FeedManager;

abstract class _FeedManager with Store {
  /// newsapi.org GET request builder
  late final RequestString _requestString;
  /// Page of the news feed
  int _page = 1;

  /// Handles http requests and provides web data to the widgets.
  _FeedManager () {
    _requestString = RequestString();
  }

  ///Provides error messages for NewsPage SnackBar
  @observable
  ObservableList<String> errorMessages = ObservableList.of(<String>[]);

  ///Provides news feed data for the UI Widgets
  @observable
  ObservableList<FeedItem> feedItems = ObservableList.of(<FeedItem>[]);

  ///Creates a list of FeedItem objects from newsapi.org response data.
  List<FeedItem> getPageItemsFromJSON(Map<String, dynamic> json){
    List<FeedItem> pageItems = <FeedItem>[];
    if (json.containsKey('articles')) {
      for (var feedItem in json['articles']) {
        pageItems.add(FeedItem.fromJson(feedItem));
      }
    }
    return pageItems;
  }

  ///Enqueue error messages to the list in case the server response contains them.
  void processErrors(Map<String, dynamic> json){
    if (json['status'] == 'error') {
      if (json.containsKey('message')) {
        errorMessages.add(json['message']);
      }else{
        errorMessages.add("The server could not process the request for a news feed.");
      }
    }
  }

  /// Clear the data from the news feed and fetch the latest feed from the remote server
  @action
  Future refreshPages() async{
    Map<String, dynamic> json = await CacheManager.requestFeed(await _requestString.build(1));
    if (json.isNotEmpty && json.containsKey("status")) {
      if (json["status"] == "ok") {
        var pageItems = getPageItemsFromJSON(json);
        if (pageItems.isNotEmpty){
          feedItems.clear();
          feedItems.addAll(pageItems);
          _page = 1;
          errorMessages.clear();
        }else{
          errorMessages.add("Couldn't update the news feed");
        }
      } else {
        processErrors(json);
      }
    }else{
      errorMessages.add("Unable to connect to the remote server");
    }
  }

  ///Fetch the next page from a news feed
  @action
  Future fetchNextPage() async{
    var page = _page + 1;
    Map<String, dynamic> json = await CacheManager.requestFeed(await _requestString.build(page));
    if (json.isNotEmpty && json.containsKey("status")) {
      if (json["status"] == "ok") {
        List<FeedItem> pageItems = getPageItemsFromJSON(json);
        feedItems.addAll(pageItems);
        errorMessages.clear();
        _page = page;
      } else {
        processErrors(json);
      }
    }else{
      errorMessages.add("Unable to connect a remote server");
    }
  }

  ///Remove the last registered error message
  @action
  String? popErrorMessage(){
    if (errorMessages.isNotEmpty){
      return errorMessages.removeLast();
    }
  }
}