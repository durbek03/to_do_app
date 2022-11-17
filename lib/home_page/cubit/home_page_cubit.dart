import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.rep) : super(HomePageState(true, List.empty())) {
    watchTasks();
  }
  final TaskRepository rep;

  watchTasks() {
    rep.watchUncompletedTasks().listen((event) {
      emit(state.copyWith(unCompletedTasks: event));
    });
  }

  hideSearch() {
    emit(state.copyWith(searchCollapsed: true));
  }

  showSearch() {
    emit(state.copyWith(searchCollapsed: false));
  }
}
