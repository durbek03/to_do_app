import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/detail_page/cubit/detail_page_cubit.dart';
import 'package:to_do_app/detail_page/task_card.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/utils/colors.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPageCubit(
          RepositoryProvider.of<TaskRepository>(context), taskId),
      child: Builder(builder: (context) {
        var cubit = BlocProvider.of<DetailPageCubit>(context);
        context.watch<DetailPageCubit>();
        return CupertinoPageScaffold(
          backgroundColor: Color(grey200),
          navigationBar: CupertinoNavigationBar(
            border: null,
            middle: Text("To do", style: TextStyle(color: Color(green700)),),
            backgroundColor: Color(grey200),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: cubit.state.task == null
                ? const CircularProgressIndicator()
                : TaskDetailCard(task: cubit.state.task!),
          ),
        );
      }),
    );
  }
}
