import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/utils/colors.dart';

import 'cubit/detail_page_cubit.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.task, required this.rep});

  final TaskData task;
  final TaskRepository rep;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPageCubit(),
      child: CupertinoPageScaffold(
        backgroundColor: Color(grey200),
        navigationBar: CupertinoNavigationBar(
          border: null,
          middle: const Text("To do"),
          backgroundColor: Color(grey200),
        ),
        child: _taskItem(),
      ),
    );
  }

  Widget _taskItem() {
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
                  if (!task.completed && !task.archieved)
                    DetailAction(
                        title: "Complete",
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        color: Color(green))
                  else
                    const SizedBox(),
                  const SizedBox(height: 10),
                  if (!task.completed)
                    const DetailAction(
                        title: "Edit",
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        color: Colors.amber),
                  if (!task.completed) const SizedBox(height: 10),
                  const DetailAction(
                      title: "Delete",
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      color: Colors.red),
                  const SizedBox(width: 5),
                ],
              ),
            )
          ],
        ),
        child: Builder(builder: (context) {
          var cubit = BlocProvider.of<DetailPageCubit>(context);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
              child: Builder(builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
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
          );
        }),
      ),
    );
  }
}

class DetailAction extends StatelessWidget {
  const DetailAction(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  final Color color;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          )
        ],
      ),
    );
  }
}
