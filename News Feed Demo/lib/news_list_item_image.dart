import 'package:flutter/material.dart';
import 'cache_manager.dart';

class NewsListItemImage extends StatelessWidget {
  ///
  late final Future<FileImage?> imageFuture;
  final double figureSize;
  NewsListItemImage({required String imageURL, required this.figureSize, Key? key}) : super(key: key){
    imageFuture = CacheManager.fetchImage(imageURL);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color : Colors.white,
        child : Container(
            margin: const EdgeInsets.all(8.0),
            child: Center(
                child : FutureBuilder<FileImage?>(
                  future: imageFuture,
                  builder: (context, snapshot) {
                    ImageProvider? image;
                    if (snapshot.hasData){
                      image = snapshot.data;
                    }
                    if (image == null) {
                      return SizedBox(
                        height: figureSize,
                        width: figureSize,
                      );
                    }else{
                      return AnimatedOpacity(
                        opacity: 1.0, // animate to 0.0 (invisible) - 1.0 (fully visible);
                        duration: const Duration(milliseconds: 800),
                        child: Image(
                          height: figureSize,
                          width: figureSize,
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                )
            )
        )
    );
  }
}