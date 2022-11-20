import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/utils/util_widgets.dart';

import 'detail_action.dart';

class TaskDetailCard extends StatelessWidget {
  TaskDetailCard({super.key, required this.task});

  final TaskData task;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Slidable(
        direction: Axis.horizontal,
        endActionPane: ActionPane(
          extentRatio: 1 / 4,
          motion: const ScrollMotion(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 5),
              child: Column(
                children: [
                  if (task.archieved)
                    DetailAction(
                      onTap: () {},
                      title: "Restore",
                      icon: const Icon(
                        Icons.restore,
                        color: Colors.white,
                      ),
                      color: Color(green),
                    ),
                  if (!task.completed && !task.archieved)
                    DetailAction(
                      onTap: () {},
                      title: "Complete",
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      color: Color(green),
                    ),
                  if (!task.completed)
                    DetailAction(
                        onTap: () {},
                        title: "Edit",
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        color: Colors.amber),
                  if (!task.completed)
                    DetailAction(
                        onTap: () {},
                        title: "Delete",
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        color: Colors.red),
                ],
              ),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [UtilWidgets.shadow],
            ),
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        child: IconButton(
                            onPressed: () {
                              var slidable = Slidable.of(context)!;
                              slidable.openEndActionPane();
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "• ${task.title}",
                    style: TextStyle(
                        color: Color(green700),
                        fontSize: 18,
                        overflow: TextOverflow.clip),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 15),
                  Text(
                      task.description,
                      style: TextStyle(fontSize: 15, color: Color(grey700))),
                  const SizedBox(height: 15),
                  Text(
                    "Due to: ${formatter.format(task.date)} \n \n \n \n",
                    style: TextStyle(fontSize: 15, color: Color(grey700)),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            }),
          ),
        ),
      ),
    );
    ;
  }
}
