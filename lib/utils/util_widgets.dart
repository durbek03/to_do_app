import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/task_dao.dart';
import 'package:to_do_app/utils/colors.dart';

import '../domain_layer/app_database.dart';

class UtilWidgets {
  static BoxShadow get shadow {
    return const BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, 1.0), //(x,y)
      blurRadius: 3.0,
    );
  }

  static Widget listItemContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          UtilWidgets.shadow,
        ],
      ),
      child: child,
    );
  }

  static Widget listItemContent(TaskData task) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "• ${task.title}",
          style: TextStyle(
              color: Color(green700),
              fontSize: 18,
              overflow: TextOverflow.clip),
          maxLines: 1,
        ),
        const SizedBox(height: 5),
        Text(
          "Due to: ${formatter.format(task.date)}",
          style: TextStyle(fontSize: 15, color: Color(grey700)),
        )
      ],
    );
  }

  static Widget restoreToast(Function onRestore) {
    return Container(
      decoration: BoxDecoration(
          color: Color(grey200),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            UtilWidgets.shadow,
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          const Text("Successfully deleted "),
          CupertinoButton(
              child: Text(
                "Restore",
                style: TextStyle(color: Color(green)),
              ),
              onPressed: () {
                onRestore.call();
              })
        ],
      ),
    );
  }
}
