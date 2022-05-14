import 'package:flutter/material.dart';
import 'package:top_news_headlines/styles.dart';

class NavigateTopButton extends StatefulWidget {
  late final ScrollController _listViewScrollController;

  /// Adds a button that resets ListView scroll position to zero.<br/>
  /// The button is positioned in the lower right corner relative to its parent,
  /// and should be stacked on the top of other controls in order to be visible. <br/>
  /// The widget takes [listViewController] parameter,
  /// which is [ListView] [ScrollController] required to control the scrollbar.
  NavigateTopButton({required ScrollController listViewController, Key? key})
      : super(key: key) {
    _listViewScrollController = listViewController;
  }

  @override
  State<StatefulWidget> createState() => _NavigateTopButtonState();
}

/// In order to animate button's opacity on build, the widget must be stateful,
/// with post frame callback updating component's own state.
class _NavigateTopButtonState extends State<NavigateTopButton> {
  ///Button widget opacity: <br/>
  /// 0.0 - fully transparent, <br/>
  /// 1.0 - use background's argb value.
  double _opacity = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 2),
        curve: Curves.easeIn,
        child: Container(
          alignment: const Alignment(0.9, 0.95),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: CustomColors.darkGray70,
            ),
            onPressed: () {
              widget._listViewScrollController.animateTo(
                  0,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500)
              );
            },
            child: const Icon(
              Icons.arrow_upward_sharp,
              color: Colors.white70,
            ),
          )
      )
    );
  }

}