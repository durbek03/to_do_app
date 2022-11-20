import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:to_do_app/utils/colors.dart';

import '../detail_page/detail_page.dart';
import '../domain_layer/app_database.dart';
import '../utils/app_animations.dart';
import '../utils/util_widgets.dart';
import 'cubit/archive_page_cubit.dart';

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
              return GestureDetector(
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
                        pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return DetailPage(taskId: task.id);
                        },
                      ),
                    );
                  },
                  child: _CompletedTask(
                    task: task,
                  ));
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
            removeAnimationBuilder: (context, animation, child) =>
                FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
  }
}

class _CompletedTask extends StatelessWidget {
  _CompletedTask({super.key, required this.task});

  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  final TaskData task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: UtilWidgets.listItemContainer(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 5),
            Text(
              "Due to: ${formatter.format(task.date)}",
              style: TextStyle(fontSize: 15, color: Color(grey700)),
            )
          ],
        ),
      ),
    );
  }
}
