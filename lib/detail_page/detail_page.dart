import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app/domain_layer/app_database.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  final TaskData task;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(),
      navigationBar: CupertinoNavigationBar(),
    );
  }
}
