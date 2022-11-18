import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/home_page/bloc/home_page_bloc.dart';
import 'package:to_do_app/home_page/search_page/search_animated_list.dart';
import 'package:to_do_app/utils/colors.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HomePageBloc>(context);
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(grey200),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(grey200),
        border: null,
        middle: Text(
          "Search",
          style: TextStyle(color: Color(green700)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Hero(
              tag: "search",
              child: SizedBox(
                height: 40,
                child: CupertinoSearchTextField(
                  onChanged: (value) {
                    bloc.add(SearchEvent(value));
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(grey500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: SlidableAutoCloseBehavior(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.all(2),
                      sliver: SearchAnimatedSliverList()
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
