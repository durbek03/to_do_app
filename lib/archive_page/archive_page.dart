import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:to_do_app/utils/colors.dart';

import '../domain_layer/app_database.dart';
import 'cubit/archive_page_cubit.dart';
import 'list_item.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchivePageCubit(RepositoryProvider.of(context)),
      child: CupertinoTabView(
        builder: (context) {
          var cubit = BlocProvider.of<ArchivePageCubit>(context);
          context.watch<ArchivePageCubit>();
          return SafeArea(
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                border: null,
                middle: CupertinoSegmentedControl<Filter>(
                  borderColor: Color(green700),
                  selectedColor: Color(green700),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  groupValue: cubit.state.filter,
                  onValueChanged: (Filter value) {
                    cubit.changeFilter(value);
                  },
                  children: const <Filter, Widget>{
                    Filter.CompletedTasks: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Completed'),
                    ),
                    Filter.ArchievedTasks: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Deleted'),
                    ),
                  },
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 2),
                          sliver: SliverAnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: cubit.state.filter == Filter.CompletedTasks
                                  ? const CompletedTasks()
                                  : ArchivedTasks()))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
          child: ListItem(task: task),
        );
      },
      insertAnimationBuilder: (context, animation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
      removeAnimationBuilder: (context, animation, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ArchivePageCubit>(context);
    context.watch<ArchivePageCubit>();
    var list = cubit.state.completedTasks;
    return DiffUtilSliverList<TaskData>(
      items: List.from(list),
      builder: (p0, task) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ListItem(task: task),
        );
      },
      insertAnimationBuilder: (context, animation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
      removeAnimationBuilder: (context, animation, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
