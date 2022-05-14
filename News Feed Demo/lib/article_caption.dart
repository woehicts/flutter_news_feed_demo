import 'package:flutter/material.dart';
import 'package:top_news_headlines/styles.dart';
import 'cache_manager.dart';

class ArticleCaption extends StatefulWidget {

  /// Caption text
  final String title;

  /// Future providing background image
  late final Future<FileImage?> imageFuture;

  /// Creates a container of width equal to the application screen width,
  /// and height that amounts to 0.625 of the container's width. <br/>
  /// Creates a background image with address "[imageURL]" using cross-fade animation, <br/>
  /// and formats a text label using text "[title]" at the lower left corner of the container.
  ArticleCaption({
    required this.title,
    required String imageURL,
    Key? key
  }) : super(key: key) {
    imageFuture = CacheManager.fetchImage(imageURL);
  }

  @override
  State<StatefulWidget> createState () => _ArticleCaptionState();
}

class _ArticleCaptionState extends State<ArticleCaption> {

  /// Builds a caption text at the lower left corner of the widget <br/>
  /// [containerWidth] - widget width <br/>
  /// [containerHeight] - widget height <br/>
  /// [headingStyle] - style of the caption text
  Widget buildCaptionText(double containerWidth, double containerHeight, TextStyle? headingStyle){
    return Container(
      height: containerHeight,
      width: containerWidth,
      alignment: const Alignment(-0.9, 0.95),
      child: Text(
        widget.title,
        maxLines: 2,
        style: headingStyle,
      ),
    );
  }

  /// Builds a caption with text "[widget.title]" in the lower left corner
  /// of this widget using cross-fade [image] background <br/><br/>
  /// [width] - width of the caption widget <br/>
  /// [height] - height of the caption widget <br/>
  /// [headingStyle] - style of the caption text <br/>
  /// [image] - the background image (if available)
  Widget buildCaption(
      double width,
      double height,
      TextStyle? headingStyle,
      ImageProvider? image) {

    return AnimatedCrossFade(
      firstChild: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        child: buildCaptionText(width, height, headingStyle),
      ),
      secondChild: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        child: buildCaptionText(width, height, headingStyle),
        decoration: BoxDecoration(
          color: CustomColors.darkGray,
          backgroundBlendMode: BlendMode.saturation,
          image: image != null ? DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ) : null
        ),
      ),
      crossFadeState: image == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FileImage?>(
        future: widget.imageFuture,
        builder: (context, snapshot) {
          var headingStyle = Theme.of(context).textTheme.headline2;
          var imageWidth = MediaQuery.of(context).size.width;
          var imageHeight = MediaQuery.of(context).size.width/1.6;

          ImageProvider? image;
          if (snapshot.hasData){
            image = snapshot.data;
          }
          return buildCaption(imageWidth, imageHeight, headingStyle, image);
        }
    );
  }
}