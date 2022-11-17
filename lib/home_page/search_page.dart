import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Search"),
      ),
      child: SafeArea(
        child: Hero(
          tag: "search",
          child: Container(
              height: 40,
              child: CupertinoSearchTextField(
                decoration: BoxDecoration(color: Color(0xFFEFEFF0)),
              )),
        ),
      ),
    );
  }
}
