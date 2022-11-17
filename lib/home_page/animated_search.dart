import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnimatedSearch extends StatefulWidget {
  AnimatedSearch({Key? key, required this.onPress}) : super(key: key);

  Function onPress;

  @override
  State<AnimatedSearch> createState() => AnimatedSearchState();
}

class AnimatedSearchState extends State<AnimatedSearch> {
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: collapsed ? 0 : 40,
        duration: Duration(milliseconds: 250),
        child: GestureDetector(
          onTap: () {
            widget.onPress.call();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFEFEFF0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              SizedBox(width: 7),
              Icon(
                CupertinoIcons.search,
                color: Color(0xFF848488),
                size: 20,
              ),
              SizedBox(width: 3),
              Text(
                "Search",
                style: TextStyle(color: Color(0xFF848488)),
              )
            ]),
          ),
        ));
  }
}
