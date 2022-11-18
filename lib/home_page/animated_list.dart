import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/home_page/slidable_list_item.dart';
import 'package:to_do_app/utils/colors.dart';

import 'cubit/home_page_cubit.dart';

class AnimatedSliverList extends StatelessWidget {
  AnimatedSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((HomePageCubit cubit) => cubit.state.unCompletedTasks);
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
                    var cubit = BlocProvider.of<HomePageCubit>(context);
                    var fToast = RepositoryProvider.of<FToast>(context);

                    cubit.completeTask(task);
                  },
                  deleteClick: () {
                    var cubit = BlocProvider.of<HomePageCubit>(context);

                    cubit.deleteTask(task.id);
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
    ;
  }
}
