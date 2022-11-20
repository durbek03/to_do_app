import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:to_do_app/detail_page/detail_page.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/home_page/bloc/home_page_bloc.dart';
import 'package:to_do_app/home_page/home_page_dialogs.dart';
import 'package:to_do_app/home_page/home_page_list_item.dart';
import 'package:to_do_app/utils/app_animations.dart';
import 'package:to_do_app/utils/colors.dart';

class AnimatedSliverList extends StatelessWidget {
  AnimatedSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    var toast = RepositoryProvider.of<FToast>(context);
    context.select((HomePageBloc cubit) => cubit.state.unCompletedTasks);
    var bloc = BlocProvider.of<HomePageBloc>(context);
    var list = bloc.state.unCompletedTasks;

    var page = list.isEmpty
        ? SliverPadding(
            padding: const EdgeInsets.only(top: 50),
            sliver: SliverToBoxAdapter(
                child: Column(
              children: [
                Image.asset(
                  'lib/assets/empty.png',
                  color: Color(green),
                  scale: 5,
                ),
                const SizedBox(height: 10),
                Text(
                  "No data to show",
                  style: TextStyle(color: Color(green700)),
                ),
              ],
            )),
          )
        : DiffUtilSliverList<TaskData>(
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DetailPage(taskId: task.id);
                          },
                        ));
                  },
                  child: HomePageListItem(
                    task: task,
                    completeClick: () {
                      bloc.add(TaskUpdateEvent(task.copyWith(completed: true)));
                    },
                    deleteClick: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (_) => DeletionDialog(
                              bloc: bloc, task: task, toast: toast));
                    },
                  ),
                ),
              );
            },
            insertAnimationBuilder: (context, animation, child) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ),
            removeAnimationBuilder: (context, animation, child) =>
                AppAnimations.listItemRemoveAnim(animation, child));
    return SliverAnimatedSwitcher(
        duration: const Duration(milliseconds: 200), child: page);
  }
}
