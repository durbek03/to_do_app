import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/utils/app_animations.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/utils/util_widgets.dart';

import '../detail_page/detail_page.dart';
import '../domain_layer/app_database.dart';
import 'cubit/archive_page_cubit.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ArchivePageCubit>(context);
    context.watch<ArchivePageCubit>();
    var list = cubit.state.archievedTasks;
    return DiffUtilSliverList<TaskData>(
      items: List.from(list),
      builder: (p0, task) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return AppAnimations.routeNavigationAnim(
                          animation, child);
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return DetailPage(taskId: task.id);
                    },
                  ),
                );
              },
              child: _ArchiveTaskSlidable(task: task)),
        );
      },
      insertAnimationBuilder: (context, animation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      removeAnimationBuilder: (context, animation, child) =>
          AppAnimations.listItemRemoveAnim(animation, child),
    );
  }
}

class _ArchiveTaskSlidable extends StatelessWidget {
  const _ArchiveTaskSlidable({super.key, required this.task});

  final TaskData task;

  @override
  Widget build(BuildContext context) {
    final rep = RepositoryProvider.of<TaskRepository>(context);
    return UtilWidgets.listItemContainer(
      Slidable(
        endActionPane: ActionPane(
            extentRatio: 2 / 3,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  rep.updateTask(
                      task.copyWith(archieved: false).toCompanion(true));
                },
                icon: Icons.restore,
                label: "Restore",
                backgroundColor: Color(green),
                foregroundColor: Colors.white,
              ),
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                onPressed: (context) {
                  showCupertinoDialog(
                      context: context,
                      builder: (_) {
                        return _DeletionDialog(
                            rep: rep,
                            task: task,
                            fToast: RepositoryProvider.of<FToast>(context));
                      });
                },
                icon: Icons.delete,
                label: "Delete",
                backgroundColor: Color(red),
                foregroundColor: Colors.white,
              ),
            ]),
        child: UtilWidgets.listItemContent(task),
      ),
    );
  }
}

class _DeletionDialog extends StatelessWidget {
  const _DeletionDialog(
      {super.key, required this.rep, required this.task, required this.fToast});

  final TaskRepository rep;
  final TaskData task;
  final FToast fToast;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("This task will be deleted permanently"),
      actions: [
        CupertinoDialogAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: const Text("Confirm"),
          onPressed: () {
            rep.deleteTask(task.id);
            Navigator.of(context).pop();
            FToast().removeCustomToast();
            fToast.showToast(
              positionedToastBuilder: (context, child) => Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: child,
              ),
              gravity: ToastGravity.CENTER,
              child: UtilWidgets.restoreToast(
                () {
                  rep.addTask(task.toCompanion(true));
                  FToast().removeCustomToast();
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
