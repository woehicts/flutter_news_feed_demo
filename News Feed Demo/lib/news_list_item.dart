import 'package:flutter/material.dart';
import 'package:top_news_headlines/article_page.dart';
import 'package:top_news_headlines/feed_item.dart';
import 'package:top_news_headlines/news_list_item_image.dart';
import 'news_list_item_content.dart';

class NewsListItem extends StatelessWidget {
  final FeedItem feedData;
  ///Creates a list item consisting of an article image thumbnail,
  /// article heading and short description using the data from [FeedItem] parameter.
  const NewsListItem({required this.feedData,  Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final itemHeight = MediaQuery.of(context).size.width / 3.5;
    final figureHeight = itemHeight * 0.75;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {
                return ArticlePage(
                  feedItem: feedData
                );
              }),
        );
      },
      child:
        ConstrainedBox(
        constraints:
          BoxConstraints(
              maxHeight: itemHeight
          ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: NewsListItemImage(
                  imageURL: feedData.articleFigureURL,
                  figureSize: figureHeight,
                )
              ),
              Expanded(
                flex: 5,
                child: NewsListItemContent(
                  title: feedData.title,
                  shortDescription: feedData.shortDescription,
                )
              )
            ],
          )
        )
      )
    );
  }

}