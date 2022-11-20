import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app/utils/colors.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        color: Colors.red,
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Edit",
          style: TextStyle(color: Color(green700)),
        ),
      ),
    );
  }
}
