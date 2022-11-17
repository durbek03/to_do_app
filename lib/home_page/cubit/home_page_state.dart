// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_cubit.dart';

class HomePageState {
  bool searchCollapsed;
  List<TaskData> unCompletedTasks;

  HomePageState(this.searchCollapsed, this.unCompletedTasks);

  HomePageState copyWith({
    bool? searchCollapsed,
    List<TaskData>? unCompletedTasks,
  }) {
    return HomePageState(
      searchCollapsed ?? this.searchCollapsed,
      unCompletedTasks ?? this.unCompletedTasks,
    );
  }
}
