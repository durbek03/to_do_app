import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/home_page/animated_search.dart';
import 'package:to_do_app/home_page/animated_list.dart';
import 'package:to_do_app/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/home_page/cubit/search_cubit.dart';
import 'package:to_do_app/home_page/search_page.dart';
import 'package:to_do_app/utils/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //injecting home page cubit
    return CupertinoTabView(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomePageCubit(RepositoryProvider.of(context)),
          ),
          BlocProvider(
            create: (context) => SearchCubit(RepositoryProvider.of(context)),
          )
        ],
        child: Builder(builder: (context) {
          return CupertinoPageScaffold(
            backgroundColor: Color(grey200),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                //search collapse animation logic
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SlidableAutoCloseBehavior(
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    controller: scrollController,
                    slivers: [
                      CupertinoSliverNavigationBar(
                        border: null,
                        backgroundColor: Color(grey200),
                        largeTitle: Text(
                          "To add list",
                          style: TextStyle(color: Color(green700)),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 10),
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
                                      transitionDuration:
                                          Duration(milliseconds: 250),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const curve = Curves.ease;

                                        var tween = Tween<double>(
                                                begin: 0.0, end: 1.0)
                                            .chain(CurveTween(curve: curve));

                                        return FadeTransition(
                                          opacity: animation.drive(tween),
                                          child: FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          SearchPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          sliver: AnimatedSliverList())
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

final stringList = List<String>.generate(100, (index) => "task${index}");
