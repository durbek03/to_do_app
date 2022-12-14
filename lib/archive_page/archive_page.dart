import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:to_do_app/utils/colors.dart';
import 'archived_tasks.dart';
import 'completed_tasks.dart';
import 'cubit/archive_page_cubit.dart';

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
              backgroundColor: Color(grey200),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CupertinoSegmentedControl<Filter>(
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SlidableAutoCloseBehavior(
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 2),
                              sliver: Builder(
                                builder: (context) {
                                  late Widget page;
                                  if (cubit.state.filter ==
                                          Filter.CompletedTasks &&
                                      cubit.state.completedTasks.isNotEmpty) {
                                    page = const CompletedTasks();
                                  } else if (cubit.state.filter ==
                                          Filter.ArchievedTasks &&
                                      cubit.state.archievedTasks.isNotEmpty) {
                                    page = const ArchivedTasks();
                                  } else {
                                    page = SliverPadding(
                                        padding: const EdgeInsets.only(top: 40),
                                        sliver: SliverToBoxAdapter(
                                            child: Column(
                                          children: [
                                            Image.asset(
                                              "lib/assets/empty.png",
                                              color: Color(green),
                                              scale: 5,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "No data to show",
                                              style: TextStyle(
                                                  color: Color(green700)),
                                            ),
                                          ],
                                        )));
                                  }
                                  return SliverAnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      child: page);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
