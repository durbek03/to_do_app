import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/home_page/home_page.dart';

import 'cubit/home_page_cubit.dart';

class AnimatedSliverList extends StatelessWidget {
  const AnimatedSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((HomePageCubit cubit) => cubit.state.unCompletedTasks);
    var cubit = BlocProvider.of<HomePageCubit>(context);
    return cubit.state.unCompletedTasks.isEmpty
        ? SliverToBoxAdapter(
            child: Text("No data to show"))
        : DiffUtilSliverList<TaskData>(
            items: List.from(cubit.state.unCompletedTasks),
            builder: (p0, TaskData task) {
              return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        spacing: 10,
                        onPressed: (context) {},
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: CupertinoIcons.check_mark,
                        label: 'Complete',
                      ),
                      SlidableAction(
                        spacing: 10,
                        onPressed: (context) {},
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: CupertinoIcons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.red,
                        child: Text(task.title),
                      ),
                    ],
                  ));
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
            insertAnimationDuration: const Duration(milliseconds: 500),
          );
    ;
  }
}
