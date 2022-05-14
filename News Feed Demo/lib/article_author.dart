import 'package:flutter/material.dart';
import 'package:top_news_headlines/utilities.dart';

class ArticleAuthor extends StatelessWidget {
  /// Article author
  final String author;

  /// String indicating the time the article was published
  late final String datePublished;

  /// Creates a row containing left-aligned [author] text widget and
  /// a right-aligned [datePublished] [DateTime] string text widget,
  /// indicating the time the article was published.
  ArticleAuthor({required this.author, DateTime? datePublished, Key? key}) : super(key:key){
    if (datePublished != null) {
      this.datePublished = getISODateString(datePublished);
    }else{
      this.datePublished = "";
    }
  }
  @override
  Widget build (BuildContext context){
    var headline3 = Theme.of(context).textTheme.headline3;
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8
        ),
        child: Row (
            mainAxisSize: MainAxisSize.max,
            children : [
              Expanded(
                flex: author.length,
                child: Text(
                  author,
                  style: headline3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                )
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 10,
                child: Text(
                  datePublished,
                  style: headline3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                )
              ),
            ]
        )
    );
  }
}