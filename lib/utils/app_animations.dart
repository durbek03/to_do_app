import 'package:flutter/cupertino.dart';

class AppAnimations {
  static FadeTransition routeNavigationAnim(
      Animation<double> animation, Widget child) {
    const curve = Curves.ease;

    var tween =
        Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

    return FadeTransition(
      opacity: animation.drive(tween),
      child: child,
    );
  }

  static FadeTransition listItemRemoveAnim(
      Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        axisAlignment: 0,
        child: child,
      ),
    );
  }
}
