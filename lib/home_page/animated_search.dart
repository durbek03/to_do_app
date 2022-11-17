import 'package:flutter/cupertino.dart';

class AnimatedSearch extends StatefulWidget {
  AnimatedSearch({Key? key, required this.onPress}) : super(key: key);

  Function onPress;

  @override
  State<AnimatedSearch> createState() => AnimatedSearchState();
}

class AnimatedSearchState extends State<AnimatedSearch> {
  bool collapsed = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: collapsed ? 0 : 40,
        duration: const Duration(milliseconds: 250),
        child: GestureDetector(
          onTap: () {
            widget.onPress.call();
          },
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFEFEFF0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(children: const [
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
