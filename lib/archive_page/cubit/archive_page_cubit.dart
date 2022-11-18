import 'package:bloc/bloc.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';

part 'archive_page_state.dart';

class ArchivePageCubit extends Cubit<ArchivePageState> {
  final TaskRepository rep;
  ArchivePageCubit(this.rep)
      : super(ArchivePageState(
            archievedTasks: List.empty(), completedTasks: List.empty(), filter: Filter.CompletedTasks)) {
    rep.watchArchievedTasks().listen((event) {
      emit(state.copyWith(archievedTasks: event));
    });

    rep.watchCompletedTasks().listen((event) {
      emit(state.copyWith(completedTasks: event));
    });
  }

  changeFilter(Filter filter) {
    emit(state.copyWith(filter: filter));
  }
}
