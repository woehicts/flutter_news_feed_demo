import 'package:flutter/material.dart';

class NewsListItemContent extends StatelessWidget{
  final String title;
  final String shortDescription;
  /// Builds a Column containing - [title] TextWidget (heading),
  /// and a [shortDescription] text element.
  const NewsListItemContent({
    required this.title,
    required this.shortDescription,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    var headline3 = Theme.of(context).textTheme.headline3;
    var bodyText = Theme.of(context).textTheme.bodyText1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
        child:
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: Text(title.toUpperCase(),
                 style: headline3,
                 overflow: TextOverflow.ellipsis,
                 textAlign: TextAlign.left,
                 maxLines: 2,
            ),
          )
        ),
        Flexible(
            child: Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(child: SizedBox(width: 20.0)),
                    TextSpan(
                      text: shortDescription,
                    ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              style: bodyText,
              textAlign: TextAlign.justify,
              softWrap: false,
              maxLines: 10,
            )
        )
    ],);
  }
}