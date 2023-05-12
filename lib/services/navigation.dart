import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  push(
    Widget page,
  ) {
    if (page != null) {
      navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }

  popCount(
    int count,
    BuildContext context,
  ) {
    int ct = 0;

    Navigator.of(context).popUntil((route) {
      return ct++ == count;
    });
  }

  popToFirst(
    BuildContext context,
  ) {
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
  }

  void pushReplacement(
    Widget page,
  ) {
    if (page != null) {
      navigatorKey.currentState.pushReplacement(
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  void pop() {
    navigatorKey.currentState.pop();
  }
}
