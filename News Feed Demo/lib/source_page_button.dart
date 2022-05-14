import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'styles.dart';

/// A Button Widget that opens a browser link to the original
/// Web page of an article
class SourcePageButton extends StatelessWidget {
  ///Article URL address
  late final Uri? pageURL;

  SourcePageButton({required String pageURL, Key? key}) : super(key:key) {
    this.pageURL = Uri.tryParse(pageURL);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? heading3Style = Theme.of(context).textTheme.headline3;
    return TextButton(
        onPressed: () async => {
              if (pageURL != null){
                  if (await canLaunchUrl(pageURL!)){
                    await launchUrl(pageURL!)
                  }
                }
          },
        style: TextButton.styleFrom(
          backgroundColor: CustomColors.darkGray,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children : [
            Text(
              "Read more",
              style: TextStyle(
                color: Colors.white70,
                fontSize: heading3Style?.fontSize,
                fontFamily: heading3Style?.fontFamily,
                letterSpacing: 2
              )
            ),
            const Icon(
                Icons.chevron_right_sharp,
                color: Colors.white70
            )
          ]
        )
    );
  }

}