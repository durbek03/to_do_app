import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/edit_page/edit_page.dart';
import 'package:to_do_app/utils/app_animations.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/utils/util_widgets.dart';

import 'detail_action.dart';

class TaskDetailCard extends StatelessWidget {
  TaskDetailCard({super.key, required this.task});

  final TaskData task;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    final rep = RepositoryProvider.of<TaskRepository>(context);
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
                      onTap: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (dContext) {
                              return CupertinoAlertDialog(
                                title: const Text("Restore task"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(dContext).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text("Confirm"),
                                    onPressed: () {
                                      rep.updateTask(task
                                          .copyWith(archieved: false)
                                          .toCompanion(true));
                                      Navigator.of(dContext).pop();
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                        rep.updateTask(
                            task.copyWith(archieved: false).toCompanion(true));
                      },
                      title: "Restore",
                      icon: const Icon(
                        Icons.restore,
                        color: Colors.white,
                      ),
                      color: Color(green),
                    ),
                  if (!task.completed && !task.archieved)
                    DetailAction(
                      onTap: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (dContext) {
                              return CupertinoAlertDialog(
                                title: const Text("Restore task"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(dContext).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text("Confirm"),
                                    onPressed: () {
                                      rep.updateTask(task
                                          .copyWith(completed: true)
                                          .toCompanion(true));
                                      Navigator.of(dContext).pop();
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      title: "Complete",
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      color: Color(green),
                    ),
                  if (!task.completed)
                    DetailAction(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return AppAnimations.routeNavigationAnim(
                                    animation, child);
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return EditPage(task: task);
                              },
                            ),
                          );
                        },
                        title: "Edit",
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        color: Colors.amber),
                  if (!task.completed)
                    DetailAction(
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (_) {
                                return _DeletionDialog(
                                  rep: rep,
                                  task: task,
                                  toast: RepositoryProvider.of(context),
                                  onDelete: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              });
                        },
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
                  Container(
                    decoration: BoxDecoration(
                        color: Color(grey700),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    padding: const EdgeInsets.only(right: 20),
                    height: 80,
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        color: Color(grey700),
                        child: IconButton(
                            onPressed: () {
                              var slidable = Slidable.of(context)!;
                              slidable.openEndActionPane();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
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
                        const SizedBox(height: 15),
                        Text(task.description,
                            style:
                                TextStyle(fontSize: 15, color: Color(grey700))),
                        const SizedBox(height: 15),
                        Text(
                          "Due to: ${formatter.format(task.date)}",
                          style: TextStyle(fontSize: 15, color: Color(grey700)),
                        )
                      ],
                    ),
                  ),
                  Container(height: 50)
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _DeletionDialog extends StatelessWidget {
  const _DeletionDialog(
      {super.key,
      required this.rep,
      required this.task,
      required this.toast,
      required this.onDelete});

  final TaskRepository rep;
  final TaskData task;
  final FToast toast;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(task.archieved
          ? "This task will be deleted permanently"
          : "Are you sure to delete task"),
      actions: [
        CupertinoDialogAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        if (!task.archieved)
          CupertinoDialogAction(
            child: const Text("Delete"),
            onPressed: () {
              rep.updateTask(task.copyWith(archieved: true).toCompanion(true));
              Navigator.of(context).pop();
              onDelete.call();
              FToast().removeCustomToast();
              toast.showToast(
                positionedToastBuilder: (context, child) =>
                    Positioned(bottom: 100, left: 0, right: 0, child: child),
                gravity: ToastGravity.CENTER,
                child: UtilWidgets.restoreToast(
                  () {
                    rep.updateTask(
                        task.copyWith(archieved: false).toCompanion(true));
                    FToast().removeCustomToast();
                  },
                ),
              );
            },
          ),
        CupertinoDialogAction(
          child: Text(task.archieved ? "Delete" : "Delete forever"),
          onPressed: () {
            rep.deleteTask(task.id);
            Navigator.of(context).pop();
            onDelete.call();
            FToast().removeCustomToast();
            toast.showToast(
              positionedToastBuilder: (context, child) =>
                  Positioned(bottom: 100, left: 0, right: 0, child: child),
              child: UtilWidgets.restoreToast(
                () {
                  rep.addTask(task.toCompanion(true));
                  FToast().removeCustomToast();
                },
              ),
            );
          },
        )
      ],
    );
  }
}
