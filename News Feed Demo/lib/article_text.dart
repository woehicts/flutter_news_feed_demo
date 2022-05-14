import 'package:flutter/material.dart';

class ArticleText extends StatelessWidget {

  /// Text content of the widget
  final String text;

  /// Creates a text widget with justified text alignment and 40px indentation
  /// of the first line.
  const ArticleText({required this.text, Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var bodyText = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0
      ),
      child: Text.rich(
        TextSpan(
          children: [
            const WidgetSpan(child: SizedBox(width: 40.0)),
            TextSpan(
              text: text,
            ),
          ],
        ),
        overflow: TextOverflow.ellipsis,
        style: bodyText,
        textAlign: TextAlign.justify,
        softWrap: false,
        maxLines: 10,
      )
    );
  }
}