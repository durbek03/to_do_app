import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/home_page/animated_search.dart';
import 'package:to_do_app/home_page/animated_list.dart';
import 'package:to_do_app/home_page/bloc/home_page_bloc.dart';
import 'package:to_do_app/home_page/search_page/search_page.dart';
import 'package:to_do_app/utils/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //injecting home page cubit
    return CupertinoTabView(
      builder: (context) => BlocProvider(
        create: (context) => HomePageBloc(RepositoryProvider.of(context)),
        child: Builder(builder: (context) {
          var bloc = BlocProvider.of<HomePageBloc>(context);
          return CupertinoPageScaffold(
            backgroundColor: Color(grey200),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                //search collapse animation logic
                if (scrollController.offset < -10 &&
                    scrollController.position.userScrollDirection ==
                        ScrollDirection.forward &&
                    bloc.state.searchCollapsed) {
                  bloc.add(SearchCollapseChangeEvent(false));
                } else {
                  if (!bloc.state.searchCollapsed &&
                      scrollController.position.userScrollDirection ==
                          ScrollDirection.reverse) {
                    bloc.add(SearchCollapseChangeEvent(true));
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
                              value: BlocProvider.of<HomePageBloc>(context),
                              child: AnimatedSearch(
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 250),
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
                                        pageBuilder: (_, animation,
                                                secondaryAnimation) =>
                                            BlocProvider.value(
                                              value: BlocProvider.of<
                                                  HomePageBloc>(context),
                                              child: SearchPage(),
                                            )),
                                  ).whenComplete(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        sliver: Builder(
                          builder: (context) {
                            return AnimatedSliverList();
                          },
                        ),
                      )
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
