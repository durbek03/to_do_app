import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_dao.dart';

class TaskRepository {
  final AppDatabase db;
  TaskRepository(this.db);

  addTask(TaskCompanion entry) {
    getDao().addTask(entry);
  }

  updateTask(TaskCompanion entry) {
    getDao().updateTask(entry);
  }

  deleteTask(int id) {
    getDao().deleteTask(id);
  }

  Stream<List<TaskData>> watchUncompletedTasks() {
    return getDao().watchUncompletedTasks();
  }

  TaskDao getDao() {
    return db.taskDao;
  }
}
