// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

class HomePageState {
  bool searchCollapsed;
  List<TaskData> unCompletedTasks;
  List<TaskData> searchResult;
  String search;

  HomePageState(
      {required this.searchCollapsed,
      required this.unCompletedTasks,
      required this.searchResult,
      required this.search});

  HomePageState copyWith({
    bool? searchCollapsed,
    List<TaskData>? unCompletedTasks,
    List<TaskData>? searchResult,
    String? search,
  }) {
    return HomePageState(
      searchCollapsed: searchCollapsed ?? this.searchCollapsed,
      unCompletedTasks: unCompletedTasks ?? this.unCompletedTasks,
      searchResult: searchResult ?? this.searchResult,
      search: search ?? this.search,
    );
  }
}
