import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/utils/util_widgets.dart';

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
      decoration: BoxDecoration(boxShadow: [
        UtilWidgets.shadow
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
