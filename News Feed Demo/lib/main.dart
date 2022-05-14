import 'package:flutter/material.dart';
import 'package:top_news_headlines/feed_manager.dart';
import 'news_page.dart';
import 'styles.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of the application. Various widgets use the provided
        // style templates as a base style for decoration of a component.
        primaryColor: CustomColors.darkGray,
        textTheme:
          const TextTheme(
            headline1: TextStyle(
                fontFamily: "Oswald",
                fontSize: 24,
                color: Colors.white70),
              headline2: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 20,
                  backgroundColor: Colors.white54,
                  color: Colors.black),
            headline3: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 16,
                color: Colors.black
            ),
            bodyText1:
              TextStyle(
                fontFamily: "Cooper Hewitt",
                fontSize: 12,
                color: Colors.black
              ),
              bodyText2:
              TextStyle(
                  fontFamily: "Cooper Hewitt",
                  fontSize: 12,
                  color: Colors.white70,
              )
          )
      ),
      home: MyHomePage(title: 'News Feed Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  late final FeedManager _feedManager;
  MyHomePage({Key? key, required this.title}) : super(key: key){
    _feedManager = FeedManager();
  }

  /// A window title
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /// Creates a fixed text element on the top of the page
  AppBar buildAppBar(BuildContext context){
    return AppBar(
      backgroundColor: CustomColors.darkGray,
      foregroundColor: Colors.white70,
      title: const Center (
          child: Text(
          "Articles",
          style: TextStyle(
              fontFamily: "Oswald",
              fontSize: 24,
              color: Colors.white70),
          )
      )
    );
  }
  /// Builds a [Scaffold] widget for material app, containing an [AppBar] and a
  /// [NewsPage] as an initial widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
        body: NewsPage(
          feedManager: widget._feedManager,
        ),
    );
  }
}
