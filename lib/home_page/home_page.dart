import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/home_page/animated_search.dart';
import 'package:to_do_app/home_page/animated_list.dart';
import 'package:to_do_app/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/home_page/search_page.dart';
import 'package:to_do_app/utils/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomePageCubit(RepositoryProvider.of<TaskRepository>(context)),
      child: Builder(builder: (context) {
        return CupertinoPageScaffold(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              var cubit = BlocProvider.of<HomePageCubit>(context);
              if (scrollController.offset < -10 &&
                  scrollController.position.userScrollDirection ==
                      ScrollDirection.forward &&
                  cubit.state.searchCollapsed) {
                cubit.showSearch();
              } else {
                if (!cubit.state.searchCollapsed &&
                    scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                  cubit.hideSearch();
                }
              }
              return true;
            },
            
            child: SlidableAutoCloseBehavior(
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: scrollController,
                slivers: [
                  CupertinoSliverNavigationBar(
                    border: Border(bottom: BorderSide(color: Color(brown500))),
                    largeTitle: Text(
                      "To do list",
                      style: TextStyle(color: dirtyWhite),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverToBoxAdapter(
                      child: Hero(
                        tag: "search",
                        child: BlocProvider.value(
                          value: BlocProvider.of<HomePageCubit>(context),
                          child: AnimatedSearch(
                            onPress: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return SearchPage();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedSliverList()
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

final stringList = List<String>.generate(100, (index) => "task${index}");
