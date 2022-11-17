import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/home_page/home_page.dart';
import 'package:to_do_app/utils/colors.dart';

import 'cubit/home_page_cubit.dart';

class AnimatedSliverList extends StatelessWidget {
  AnimatedSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((HomePageCubit cubit) => cubit.state.unCompletedTasks);
    var cubit = BlocProvider.of<HomePageCubit>(context);
    return cubit.state.unCompletedTasks.isEmpty
        ? SliverToBoxAdapter(child: Text("No data to show"))
        : SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            sliver: DiffUtilSliverList<TaskData>(
              items: List.from(cubit.state.unCompletedTasks),
              builder: (p0, TaskData task) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ListItem(task: task),
                );
              },
              insertAnimationBuilder: (context, animation, child) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
              removeAnimationBuilder: (context, animation, child) =>
                  SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
              removeAnimationDuration: const Duration(milliseconds: 250),
              insertAnimationDuration: const Duration(milliseconds: 250),
            ),
          );
    ;
  }
}

class _ListItem extends StatelessWidget {
  _ListItem({super.key, required this.task});

  final TaskData task;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            spacing: 10,
            onPressed: (context) {},
            backgroundColor: Color(blue),
            foregroundColor: Colors.white,
            icon: CupertinoIcons.check_mark,
            label: 'Complete',
          ),
          Builder(builder: (context) {
            return SlidableAction(
              spacing: 10,
              onPressed: (context) {
                var cubit = BlocProvider.of<HomePageCubit>(context);
                cubit.deleteTask(task.id);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: CupertinoIcons.delete,
              label: 'Delete',
            );
          }),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(brown500), borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "• ${task.title}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  overflow: TextOverflow.clip),
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              "Due to: ${formatter.format(task.date)}",
              style: TextStyle(color: dirtyWhite, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
