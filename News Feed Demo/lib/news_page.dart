import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:top_news_headlines/error_bar.dart';
import 'package:top_news_headlines/navigate_top_button.dart';
import 'feed_item.dart';
import 'feed_manager.dart';
import 'styles.dart';

import 'news_list_item.dart';

class NewsPage extends StatefulWidget {
  /// Provides data for this widget
  final FeedManager feedManager;

  /// Displays a list of news feed items retrieved by the [feedManager].
  /// Each list item contains a thumbnail of an editorial photo of the article
  /// on the left with article's title and short description to the right of the image.
  const NewsPage({
    required this.feedManager,
    Key? key
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

/// A state class for [NewsPage] in order to control whether
/// to display the navigate top button;
class _NewsPageState extends State<NewsPage> {
  late final ScrollController _scrollController;
  /// When a ListView is scrolled below an initial list element, indicates to display
  /// a navigate-to-top widget
  bool _showScrollTopButton = false;
  /// don't send another request if the old one is still in progress.
  bool _fetchNextPageRequested = false;

  /// Instructs to load a new page of the news feed when the list is scrolled down
  /// past 95% extent. Also decides when to display the scroll-to-top button.
  _scrollListener() {
    if (!_fetchNextPageRequested
        && _scrollController.offset >= _scrollController.position.maxScrollExtent * 0.95) {
      _fetchNextPageRequested = true;
      widget.feedManager.fetchNextPage().whenComplete(() {
        _fetchNextPageRequested = false;
      });
    }
    if (_scrollController.offset <= _scrollController.position.minScrollExtent) {
      setState(() {
        _showScrollTopButton = false;
      });
    }else{
      setState(() {
        _showScrollTopButton = true;
      });
    }
  }

  /// Loads initial news feed and initializes
  /// a custom scroll controller for the ListView of a news feed.
  @override
  void initState() {
    widget.feedManager.fetchNextPage();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Observer(
      builder: ( BuildContext context) {

        var feedItems = widget.feedManager.feedItems;
        var errorMessages = widget.feedManager.errorMessages;
        /*if (errorMessages.isNotEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(errorMessages.last),
                action: SnackBarAction(
                  label: "Dismiss",
                  onPressed: () => widget.feedManager.popErrorMessage(),
                ),
            )
          );
        }*/

        List<FeedItem> items = feedItems.toList();
        final dividerIndent = MediaQuery.of(context).size.width/6.0;

        return RefreshIndicator(
          onRefresh: () async => widget.feedManager.refreshPages(),
          triggerMode: RefreshIndicatorTriggerMode.onEdge,

          color: Colors.white70,
          backgroundColor: CustomColors.darkGray,
          child: Stack( //stack listview and navigate top button
              children: [
                ListView.builder(
                physics:
                const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: items.length,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  // construct a list item from a data entry
                  return Column(
                      children : [
                        NewsListItem(
                          feedData: items[index]
                        ),
                        if (index != items.length - 1)
                          Divider(
                            color: CustomColors.darkGray,
                            height: 16,
                            indent: dividerIndent,
                            endIndent: dividerIndent
                          )
                      ]
                  );
                }
              ),
              if (_showScrollTopButton)
                NavigateTopButton(listViewController: _scrollController),
              if (errorMessages.isNotEmpty)
                ErrorBar(
                    errorMessage: errorMessages.last,
                    onDismiss: () => widget.feedManager.popErrorMessage()
                )
            ]
          ),// This trailing comma makes auto-formatting nicer for build methods.
        );
    }
  );
}
