import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'cubit/home_page_cubit.dart';

class AnimatedSliverList extends StatelessWidget {
  const AnimatedSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<HomePageCubit>();
                  var cubit = BlocProvider.of<HomePageCubit>(context);
                  List<String> list = cubit.state;
    return DiffUtilSliverList<String>(
      items: List.from(list),
      builder: (p0, String str) {
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
                  onPressed: (context) {
                    cubit.deleteItemAt(str);
                  },
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
                  child: Text(str),
                ),
              ],
            ));
      },
      insertAnimationBuilder: (context, animation, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      removeAnimationBuilder: (context, animation, child) => SizeTransition(
        sizeFactor: animation,
        child: child,
      ),
      removeAnimationDuration: const Duration(milliseconds: 250),
      insertAnimationDuration: const Duration(milliseconds: 500),
    );
    ;
  }
}
