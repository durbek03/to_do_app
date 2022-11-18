import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final TaskRepository rep;
  HomePageBloc(this.rep)
      : super(
          HomePageState(
              search: "",
              searchCollapsed: true,
              searchResult: List.empty(),
              unCompletedTasks: List.empty()),
        ) {
    rep.watchUncompletedTasks().listen((event) {
      add(NewTasksEvent(event));
    });
    on<SearchCollapseChangeEvent>(
      (event, emit) {
        emit(state.copyWith(searchCollapsed: event.collapsed));
      },
    );
    on<SearchEvent>(
      (event, emit) async {
        if (event.query.isEmpty) return;
        var result = await rep.searchTask(event.query);
        emit(state.copyWith(search: event.query, searchResult: result));
      },
    );
    on<TaskDeleteEvent>(
      (event, emit) {
        rep.deleteTask(event.id);
      },
    );
    on<TaskUpdateEvent>(
      (event, emit) {
        rep.updateTask(event.task.toCompanion(true));
      },
    );
    on<TaskAddEvent>(
      (event, emit) {
        rep.addTask(event.task.toCompanion(true));
      },
    );
    on<NewTasksEvent>(
      (event, emit) async {
        add(SearchEvent(state.search));
        emit(
            state.copyWith(unCompletedTasks: event.list));
      },
    );
  }
}
