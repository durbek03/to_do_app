import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do_app/home_page/animated_search.dart';
import 'package:to_do_app/home_page/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();
  final GlobalKey<AnimatedSearchState> _searchKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          var state = _searchKey.currentState!;
          if (scrollController.offset < -10 &&
              scrollController.position.userScrollDirection ==
                  ScrollDirection.forward &&
              state.collapsed) {
            state.setState(() {
              state.collapsed = false;
            });
          } else {
            if (!state.collapsed &&
                scrollController.position.userScrollDirection ==
                    ScrollDirection.reverse) {
              state.setState(() {
                _searchKey.currentState!.collapsed = true;
              });
            }
          }
          return true;
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text("To do list"),
            ),
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: Hero(
                  tag: "search",
                  child: AnimatedSearch(
                    key: _searchKey,
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
            SliverAnimatedList(
              itemBuilder: (context, index, animation) {
                return Container(
                  child: Text("hello there"),
                  padding: EdgeInsets.all(10),
                );
              },
              initialItemCount: 100,
            )
          ],
        ),
      ),
    );
  }
}
