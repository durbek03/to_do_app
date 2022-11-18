// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_cubit.dart';

class HomePageState {
  bool searchCollapsed;
  List<TaskData> unCompletedTasks;

  HomePageState({
    required this.searchCollapsed,
    required this.unCompletedTasks,
  });

  HomePageState copyWith({
    bool? searchCollapsed,
    List<TaskData>? unCompletedTasks,
    String? search,
    List<TaskData>? searchResult,
  }) {
    return HomePageState(
      searchCollapsed: searchCollapsed ?? this.searchCollapsed,
      unCompletedTasks: unCompletedTasks ?? this.unCompletedTasks,
    );
  }
}
