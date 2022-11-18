// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'archive_page_cubit.dart';

class ArchivePageState {
  final List<TaskData> completedTasks;
  final List<TaskData> archievedTasks;
  final Filter filter;

  ArchivePageState(
      {required this.archievedTasks, required this.completedTasks, required this.filter});

  ArchivePageState copyWith({
    List<TaskData>? completedTasks,
    List<TaskData>? archievedTasks,
    Filter? filter
  }) {
    return ArchivePageState(
      completedTasks: completedTasks ?? this.completedTasks,
      archievedTasks: archievedTasks ?? this.archievedTasks,
      filter: filter ?? this.filter
    );
  }
}
enum Filter { CompletedTasks, ArchievedTasks }