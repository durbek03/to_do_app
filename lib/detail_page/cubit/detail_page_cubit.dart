import 'package:bloc/bloc.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';

part 'detail_page_state.dart';

class DetailPageCubit extends Cubit<DetailPageState> {
  final TaskRepository rep;
  final int taskId;

  DetailPageCubit(this.rep, this.taskId)
      : super(const DetailPageState(task: null)) {
    watchTaskChange();
  }

  watchTaskChange() {
    rep.watchTask(taskId).listen((event) {
      emit(state.copyWith(task: event));
    });
  }
}
