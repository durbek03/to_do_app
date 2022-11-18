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

  Future updateTask(TaskCompanion entry) {
    return update(task).replace(entry);
  }

  Future deleteTask(int id) {
    return (delete(task)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<TaskData>> watchUncompletedTasks() {
    return (select(task)..where((tbl) {
      return tbl.completed.equals(false) & tbl.archieved.equals(false);
    })..orderBy([(table) => OrderingTerm.asc(table.date)])).watch();
  }
}
