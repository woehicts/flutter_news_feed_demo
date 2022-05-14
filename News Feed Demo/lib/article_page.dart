import 'package:flutter/material.dart';
import 'package:top_news_headlines/article_author.dart';
import 'package:top_news_headlines/article_caption.dart';
import 'package:top_news_headlines/article_text.dart';
import 'package:top_news_headlines/source_page_button.dart';

import 'feed_item.dart';

class ArticlePage extends StatelessWidget{
  final FeedItem feedItem;
  /// Creates a caption for a news article with an editorial picture on the top of the page,
  /// displays article's author and date when it was published below the top,
  /// followed by an excerpt from the text of the article.
  /// Finally, displays a button providing a browser link to the full article at the page bottom.
  const ArticlePage({required this.feedItem, Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Dismissible(
      // A device theme may override primary and secondary background
      // colors, as a result the fonts in the article could become invisible.
      secondaryBackground: Container(
        color: Colors.white,
        ),
        background: Container(
          color: Colors.white,
        ),
        onDismissed: (direction) {
          Navigator.pop(context);
        },
        key: key ?? const Key("key"),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child:
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight
                ),
                child:
                  IntrinsicHeight(
                    child :
                      Column(
                        children:[
                          ArticleCaption(
                              title: feedItem.title,
                              imageURL: feedItem.articleFigureURL
                          ),
                          ArticleAuthor(
                              author: feedItem.author,
                              datePublished: feedItem.timePublished),
                          ArticleText(
                              text: feedItem.longDescription
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 16.0
                            ),
                            child:
                              SourcePageButton(
                                  pageURL: feedItem.articleAddress
                              )
                          )
                      ]
                    ),
                  )
            )
          )
        ),
    );
  }
}