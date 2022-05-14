// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedManager on _FeedManager, Store {
  late final _$errorMessagesAtom =
      Atom(name: '_FeedManager.errorMessages', context: context);

  @override
  ObservableList<String> get errorMessages {
    _$errorMessagesAtom.reportRead();
    return super.errorMessages;
  }

  @override
  set errorMessages(ObservableList<String> value) {
    _$errorMessagesAtom.reportWrite(value, super.errorMessages, () {
      super.errorMessages = value;
    });
  }

  late final _$feedItemsAtom =
      Atom(name: '_FeedManager.feedItems', context: context);

  @override
  ObservableList<FeedItem> get feedItems {
    _$feedItemsAtom.reportRead();
    return super.feedItems;
  }

  @override
  set feedItems(ObservableList<FeedItem> value) {
    _$feedItemsAtom.reportWrite(value, super.feedItems, () {
      super.feedItems = value;
    });
  }

  late final _$refreshPagesAsyncAction =
      AsyncAction('_FeedManager.refreshPages', context: context);

  @override
  Future<dynamic> refreshPages() {
    return _$refreshPagesAsyncAction.run(() => super.refreshPages());
  }

  late final _$fetchNextPageAsyncAction =
      AsyncAction('_FeedManager.fetchNextPage', context: context);

  @override
  Future<dynamic> fetchNextPage() {
    return _$fetchNextPageAsyncAction.run(() => super.fetchNextPage());
  }

  late final _$_FeedManagerActionController =
      ActionController(name: '_FeedManager', context: context);

  @override
  String? popErrorMessage() {
    final _$actionInfo = _$_FeedManagerActionController.startAction(
        name: '_FeedManager.popErrorMessage');
    try {
      return super.popErrorMessage();
    } finally {
      _$_FeedManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessages: ${errorMessages},
feedItems: ${feedItems}
    ''';
  }
}
