import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.title,
      required this.color,
      required this.onTap});

  final String title;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        child: Container(
          height: 35,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
