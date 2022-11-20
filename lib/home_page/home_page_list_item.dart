import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/utils/util_widgets.dart';

import '../domain_layer/app_database.dart';

class HomePageListItem extends StatelessWidget {
  HomePageListItem(
      {super.key,
      required this.task,
      required this.completeClick,
      required this.deleteClick});

  final TaskData task;
  final Function completeClick;
  final Function deleteClick;

  @override
  Widget build(BuildContext context) {
    return UtilWidgets.listItemContainer(
      Slidable(
        endActionPane: ActionPane(
          extentRatio: 3 / 5,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              spacing: 10,
              onPressed: (context) {
                completeClick.call();
              },
              backgroundColor: Color(green),
              foregroundColor: Colors.white,
              icon: CupertinoIcons.check_mark,
              label: 'Complete',
            ),
            Builder(builder: (context) {
              return SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                spacing: 10,
                onPressed: (context) {
                  deleteClick.call();
                },
                backgroundColor: Color(red),
                foregroundColor: Colors.white,
                icon: CupertinoIcons.delete,
                label: 'Delete',
              );
            }),
          ],
        ),
        child: UtilWidgets.listItemContent(task),
      ),
    );
  }
}
