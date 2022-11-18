import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/utils/colors.dart';

import '../domain_layer/app_database.dart';
import 'cubit/home_page_cubit.dart';

class SlidableListItem extends StatelessWidget {
  SlidableListItem(
      {super.key,
      required this.task,
      required this.completeClick,
      required this.deleteClick});

  final TaskData task;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  final Function completeClick;
  final Function deleteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Slidable(   
        endActionPane: ActionPane(
          extentRatio: 2 / 3,
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
                borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
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
        child: Column(
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
        ),
      ),
    );
  }
}
