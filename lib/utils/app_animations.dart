import 'package:flutter/cupertino.dart';

class AppAnimations {
  static FadeTransition Function(Animation<double> animation, Widget child) get routeNavigationAnim => (animation, child) {
    const curve = Curves.ease;

    var tween =
        Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

    return FadeTransition(
      opacity: animation.drive(tween),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  };

  static FadeTransition Function(Animation<double> animation, Widget child) get listItemRemoveAnim => (animation, child) {
    return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: child,
              ),
            );
  };
}
