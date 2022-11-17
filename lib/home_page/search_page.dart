import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app/utils/colors.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Search", style: TextStyle(color: dirtyWhite),),
      ),
      child: SafeArea(
        child: Hero(
          tag: "search",
          child: Container(
              height: 40,
              child: CupertinoSearchTextField(
                style: TextStyle(color:dirtyWhite),
                controller: controller,
                itemColor: dirtyWhite,
                decoration: BoxDecoration(color: Color(brown500)),
              )),
        ),
      ),
    );
  }
}
