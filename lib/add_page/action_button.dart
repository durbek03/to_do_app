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
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 3.0,
        )
      ]),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 35,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
