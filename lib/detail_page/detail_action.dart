import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/utils/util_widgets.dart';

class DetailAction extends StatelessWidget {
  const DetailAction(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  final Color color;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        boxShadow: [
          UtilWidgets.shadow
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          )
        ],
      ),
    );
  }
}