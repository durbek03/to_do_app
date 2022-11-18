import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/home_page/slidable_list_item.dart';
import 'package:to_do_app/utils/widgets.dart';

import 'cubit/home_page_cubit.dart';

class AnimatedSliverList extends StatelessWidget {
  AnimatedSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((HomePageCubit cubit) => cubit.state.unCompletedTasks);
    var toast = RepositoryProvider.of<FToast>(context);
    var cubit = BlocProvider.of<HomePageCubit>(context);

    return cubit.state.unCompletedTasks.isEmpty
        ? const SliverToBoxAdapter(child: Text("No data to show"))
        : DiffUtilSliverList<TaskData>(
            items: List.from(cubit.state.unCompletedTasks),
            builder: (p0, task) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SlidableListItem(
                  task: task,
                  completeClick: () {
                    _showCompleteDialog(context, task);
                  },
                  deleteClick: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) => DeleteionDialog(
                            rep: RepositoryProvider.of(context),
                            task: task,
                            toast: toast));
                  },
                ),
              );
            },
            insertAnimationBuilder: (context, animation, child) =>
                FadeTransition(
              opacity: animation,
              child: child,
            ),
            removeAnimationBuilder: (context, animation, child) =>
                FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: child,
              ),
            ),
          );
  }

  void _showCompleteDialog(BuildContext bContext, TaskData task) {
    showCupertinoDialog(
      context: bContext,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Press confirm to complete task"),
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
                BlocProvider.of<HomePageCubit>(context).completeTask(task);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
