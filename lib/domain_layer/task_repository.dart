import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_dao.dart';

class TaskRepository {
  final AppDatabase db;
  TaskRepository(this.db);

  addTask(TaskCompanion entry) {
    getDao().addTask(entry);
  }

  Future updateTask(TaskCompanion entry) {
    return getDao().updateTask(entry);
  }

  Future deleteTask(int id) {
    return getDao().deleteTask(id);
  }

  Stream<List<TaskData>> watchUncompletedTasks() {
    return getDao().watchUncompletedTasks();
  }

  Future<List<TaskData>> searchTask(String entry) {
    return getDao().searchTask(entry);
  }

  TaskDao getDao() {
    return db.taskDao;
  }
}
