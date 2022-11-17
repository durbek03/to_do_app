import 'package:drift/drift.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Task])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.attachedDatabase);

  addTask(TaskCompanion entry) {
    into(task).insert(entry);
  }

  updateTask(TaskCompanion entry) {
    update(task).replace(entry);
  }

  deleteTask(int id) {
    delete(task).where((tbl) => tbl.id.equals(id));
  }

  Stream<List<TaskData>> watchUncompletedTasks() {
    return (select(task)..where((tbl) => tbl.completed.equals(false))).watch();
  }
}
