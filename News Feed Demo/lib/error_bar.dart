import 'package:flutter/material.dart';
import 'package:top_news_headlines/styles.dart';

class ErrorBar extends StatelessWidget {
  final void Function()? onDismiss;
  final String errorMessage;
  const ErrorBar({required this.errorMessage, required this.onDismiss, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bodyTextStyle = Theme.of(context).textTheme.bodyText2;
    var heading3Style = Theme.of(context).textTheme.headline3;
    var screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: screenSize.height/4.0
        ),
        padding: const EdgeInsets.all(8),
        color: CustomColors.darkGray,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Text(
                  errorMessage,
                  textAlign: TextAlign.justify,
                  style: bodyTextStyle,
              )
            ),
            Flexible(
              flex : 1,
              child: Center(
                child:
                  TextButton(
                    child: Text(
                      "Dismiss",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: heading3Style?.fontSize,
                        fontFamily: heading3Style?.fontFamily,
                      ),
                    ),
                    onPressed: onDismiss,
                  )
              )
            )
          ],
        )
      )
    );
  }

}