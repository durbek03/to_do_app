// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState {
  String search;
  List<TaskData> result;

  SearchState({required this.search, required this.result});

  SearchState copyWith({
    String? search,
    List<TaskData>? result,
  }) {
    return SearchState(
      search: search ?? this.search,
      result: result ?? this.result,
    );
  }
}
