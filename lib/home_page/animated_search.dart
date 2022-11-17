import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/utils/colors.dart';

class AnimatedSearch extends StatelessWidget {
  AnimatedSearch({super.key, required this.onPress});

  Function onPress;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomePageCubit>(context);
    context.select(
      (HomePageCubit value) {
        return value.state.searchCollapsed;
      },
    );
    return AnimatedContainer(
        height: cubit.state.searchCollapsed ? 0 : 40,
        duration: const Duration(milliseconds: 150),
        child: GestureDetector(
          onTap: () {
            onPress.call();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(brown500),
                borderRadius: BorderRadius.circular(5)),
            child: Row(children: const [
              SizedBox(width: 7),
              Icon(
                CupertinoIcons.search,
                color: Color(0xFF848488),
                size: 20,
              ),
              SizedBox(width: 3),
              Text(
                "Search",
                style: TextStyle(color: Color(0xFF848488)),
              )
            ]),
          ),
        ));
    ;
  }
}
