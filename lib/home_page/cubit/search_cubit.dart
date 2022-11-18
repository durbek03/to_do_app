import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';

import '../../domain_layer/app_database.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.rep) : super(SearchState(search: "", result: List.empty()));

  final TaskRepository rep;
}
