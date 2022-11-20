import 'package:flutter/material.dart';

class UtilWidgets {
  static BoxShadow get shadow {
    return const BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, 1.0), //(x,y)
      blurRadius: 3.0,
    );
  }
}
