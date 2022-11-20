// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_page_cubit.dart';

class DetailPageState {
  final TaskData? task;

  const DetailPageState({this.task});

  DetailPageState copyWith({
    TaskData? task,
  }) {
    return DetailPageState(
      task: task ?? this.task,
    );
  }
}
